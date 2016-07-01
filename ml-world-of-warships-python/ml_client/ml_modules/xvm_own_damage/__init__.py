__author__ = 'Monstrofil'
import BWPersonality, Avatar, sys
import GameParams

import ml_tools.ClientModules
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo

def receiveDamage(victimID, shooterID, ammoId, matId, shotID, booleans, damage, shotPosition, yaw, hlinfo):
    me = PlayersInfo.getSelfPlayerInfo()
    victim = PlayersInfo.getPlayerByVehicleId(victimID)
    shooter = PlayersInfo.getPlayerByVehicleId(shooterID)
    print victimID, shooterID, me.avatarId
    shotInfo = GameParams.get(ammoId)
    ammoType = shotInfo.ammoType
    shoterData = shotInfo.typeinfo.species
    if me.avatarId == shooter.avatarId:
        BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("onVehicleDamagedByMe", [damage, victim.avatarId, ammoType, shoterData])
    if me.avatarId == victim.avatarId:
        BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("onMeDamagedByVehicle", [damage, shooter.avatarId, ammoType, shoterData])


Avatar.gReceiveShellInfo += receiveDamage
