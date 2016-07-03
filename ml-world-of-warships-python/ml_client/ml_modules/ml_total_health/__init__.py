__author__ = 'shish'
import Vehicle, Avatar

import ml_tools.ClientModules, sys, BWPersonality
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo

import ml_xvp.events
registerEvent = sys.modules['ml_xvp'].events.registerEvent

class Health():
    def __init__(self, health, maxHealth):
        self.health = health
        self.maxHealth = maxHealth

class TeamsData(object):
    def __init__(self):
        self.alliedVehicles = {}
        self.enemyVehicles = {}
        self.alliesHealth = 0
        self.enemiesHealth = 0
        self.maxAlliesHealth = 0
        self.maxEnemiesHealth = 0

        self.vehicles = {}

    def clear(self):
        self.alliedVehicles = {}
        self.enemyVehicles = {}
        self.alliesHealth = 0
        self.enemiesHealth = 0
        self.maxAlliesHealth = 0
        self.maxEnemiesHealth = 0

    def onVehicleChangedHealth(self, avatarId, health, isAlly):
        storage = self.alliedVehicles if isAlly else self.enemyVehicles

        if avatarId in storage:
            if isAlly:
                self.alliesHealth -= storage[avatarId].health
                self.maxAlliesHealth -= storage[avatarId].maxHealth
            else:
                self.enemiesHealth -= storage[avatarId].health
                self.maxEnemiesHealth -= storage[avatarId].maxHealth
        storage[avatarId] = health

        if isAlly:
            self.alliesHealth += storage[avatarId].health
            self.maxAlliesHealth += storage[avatarId].maxHealth
        else:
            self.enemiesHealth += storage[avatarId].health
            self.maxEnemiesHealth += storage[avatarId].maxHealth

        self.update()

    def update(self):
        if BWPersonality.uiManager._UIManager__mainContext.battle:
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("ML_onTeamsHpChanged", [self.alliesHealth, self.enemiesHealth, self.maxAlliesHealth, self.maxEnemiesHealth])
gTeamsData = TeamsData()

def onPlayersListUpdated(*args, **params):
    if not BWPersonality.uiManager._UIManager__mainContext.battle:
        for player in PlayersInfo.iterPlayers():
            tmpHealth = Health(player.maxHealth, player.maxHealth)
            gTeamsData.onVehicleChangedHealth(player.avatarId, tmpHealth, player.teamId==PlayersInfo.getSelfPlayerInfo().teamId)
PlayersInfo.gPlayersListUpdated += onPlayersListUpdated

old_set_health = Vehicle.Vehicle.set_health
def new_set_health(self, oldValue):
    vTeamId = PlayersInfo.getPlayerByVehicleId(self.id).teamId
    mTeamId = PlayersInfo.getSelfPlayerInfo().teamId


    tmpHealth = Health(self.health, self.maxHealth)
    gTeamsData.onVehicleChangedHealth(self.owner, tmpHealth, vTeamId == mTeamId)
    old_set_health(self, oldValue)
Vehicle.Vehicle.set_health = new_set_health

def onPreBattleStarted(*args, **params):
    gTeamsData.clear()
Avatar.evEnterPreBattle += onPreBattleStarted()

import BigWorld
def onPreBattleLeave(*args, **params):
    BigWorld.callback(5, gTeamsData.update)
Avatar.evLeavePreBattle += onPreBattleLeave()