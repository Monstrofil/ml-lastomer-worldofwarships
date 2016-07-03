__author__ = 'shish'
import Vehicle, Avatar

import ml_tools.ClientModules, sys, BWPersonality
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo

import ml_xvp.events
registerEvent = sys.modules['ml_xvp'].events.registerEvent

class TeamsData(object):
    def __init__(self):
        self.alliedVehicles = {}
        self.enemyVehicles = {}
        self.alliesHealth = 0
        self.enemiesHealth = 0

        self.vehicles = {}

    def clear(self):
        self.alliedVehicles = {}
        self.enemyVehicles = {}
        self.alliesHealth = 0
        self.enemiesHealth = 0

    def onVehicleChangedHealth(self, avatarId, health, isAlly):
        storage = self.alliedVehicles if isAlly else self.enemyVehicles
        old_alliesHealth = self.alliesHealth
        old_enemiesHealth = self.enemiesHealth

        if avatarId in storage:
            if isAlly:
                self.alliesHealth -= storage[avatarId]
            else:
                self.enemiesHealth -= storage[avatarId]
        storage[avatarId] = health

        if isAlly:
            self.alliesHealth += storage[avatarId]
        else:
            self.enemiesHealth += storage[avatarId]

        self.update((old_alliesHealth != self.alliesHealth) or (old_enemiesHealth != self.enemiesHealth))

    def update(self, flag):
        if BWPersonality.uiManager._UIManager__mainContext.battle and flag:
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("ML_onTeamsHpChanged", [self.alliesHealth, self.enemiesHealth])
gTeamsData = TeamsData()

def onPlayersListUpdated(*args, **params):
    for player in PlayersInfo.iterPlayers():
        gTeamsData.onVehicleChangedHealth(player.avatarId, player.health, player.teamId==PlayersInfo.getSelfPlayerInfo().teamId)
PlayersInfo.gPlayersListUpdated += onPlayersListUpdated

old_set_health = Vehicle.Vehicle.set_health
def new_set_health(self, oldValue):
    vTeamId = PlayersInfo.getPlayerByVehicleId(self.id).teamId
    mTeamId = PlayersInfo.getSelfPlayerInfo().teamId

    gTeamsData.onVehicleChangedHealth(self.owner, self.health, vTeamId == mTeamId)
    old_set_health(self, oldValue)
Vehicle.Vehicle.set_health = new_set_health

def onPreBattleStarted(*args, **params):
    gTeamsData.clear()
Avatar.evEnterPreBattle += onPreBattleStarted()


def onLeavePreBattle(*args, **params):
    for player in PlayersInfo.iterPlayers():
        gTeamsData.onVehicleChangedHealth(player.avatarId, player.maxHealth, player.teamId==PlayersInfo.getSelfPlayerInfo().teamId)
Avatar.evLeavePreBattle += onLeavePreBattle