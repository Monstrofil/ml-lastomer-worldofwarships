__author__ = 'Monstrofil'

import gui.Scaleform.ChatController as ChatController
import ml_xvp.events, sys, BigWorld, BWPersonality
overrideMethod = sys.modules['ml_xvp'].events.overrideMethod

import ml_tools.ClientModules
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo
VehicleStateController = sys.modules['ml_tools'].ClientModules.VehicleStateController
i18n = sys.modules['ml_tools'].ClientModules.i18n

import ml_modules.xvm_statistics.WebDataHolder
g_webDataHolder = sys.modules['ml_modules'].xvm_statistics.WebDataHolder.g_webDataHolder

old_call = BWPersonality.uiManager._UIManager__mainContext.flash.__class__.call
def new_call(*args, **params):
    name = args[1]
    if name == "FlagList.addMessage": #in order not to send original message
        return
    if name == "MLFlagList.addMessage":
        args = list(args)
        args[1] = "FlagList.addMessage"
    old_call(*args, **params)
BWPersonality.uiManager._UIManager__mainContext.flash.__class__.call = new_call

@overrideMethod(VehicleStateController, '_VehicleStateController__onVehicleDeath')
def new_VehicleStateController__onVehicleDeath(base, self, victimVehicleId, shooterVehicleId):
    print '_VehicleStateController__onVehicleDeath'
    victim = PlayersInfo.getPlayerByVehicleId(victimVehicleId)
    victimShip = i18n._gTranslator.translate('IDS_' + victim.shipInfo.shortName)
    shooter = PlayersInfo.getPlayerByVehicleId(shooterVehicleId)
    shooterShip = i18n._gTranslator.translate('IDS_' + shooter.shipInfo.shortName)
    me = PlayersInfo.getSelfPlayerInfo()

    if me.avatarId == victim.avatarId:
        color = 16777215
    if me.teamId == victim.teamId:
        color = 15232587
    if me.teamId != victim.teamId:
        color = 5040298
    if shooter.teamId == victim.teamId:
        color = 16750282

    shooterWebinfo = g_webDataHolder.playersWebData.get(shooter.name, None)
    victimWebinfo = g_webDataHolder.playersWebData.get(victim.name, None)

    shooterWebinfoFullName = shooter.name
    if shooterWebinfo != None:
        shooterWebinfoFullName = shooterWebinfo.fullName

    victimWebinfoFullName = victim.name
    if victimWebinfo != None:
        victimWebinfoFullName = victimWebinfo.fullName


    message = i18n._gTranslator.translate("IDS_INFO_KILLED") % (shooterWebinfoFullName + " (%s)"%shooterShip,
                                                                victimWebinfoFullName + " (%s)"%victimShip)

    self.main.flash.call("MLFlagList.addMessage", [message, color])

    base(self, victimVehicleId, shooterVehicleId) #in order to play sound "Ship Destroyed!11"
