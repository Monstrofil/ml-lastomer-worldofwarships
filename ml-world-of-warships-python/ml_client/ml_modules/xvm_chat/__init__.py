__author__ = 'Monstrofil'

import gui.Scaleform.ChatController as ChatController
import xvm_xvp.events, sys, BigWorld
overrideMethod = sys.modules['xvm_xvp'].events.overrideMethod

import ml_tools.ClientModules
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo

i18n = sys.modules['ml_tools'].ClientModules.i18n

import ml_modules.xvm_statistics.WebDataHolder
g_webDataHolder = sys.modules['ml_modules'].xvm_statistics.WebDataHolder.g_webDataHolder


@overrideMethod(ChatController.ChatController, '_ChatController__buildMessage')
def new_ChatController__buildMessage(*args, **params):
    print '_ChatController__buildMessage'
    try:
        args = list(args)
        info = PlayersInfo.getPlayerInfoByName(args[3])
        ship = i18n._gTranslator.translate('IDS_' + info.shipInfo.shortName)

        data = g_webDataHolder.playersWebData.get(info.name, None)

        if data is not None and data.inClan:
            args[3] = '%s[%s] (%s)' % (args[3], data.clanTag, ship)
        else:
            args[3] = '%s (%s)' % (args[3], ship)

    except Exception, ex:
        print ex

    args[0](*args[1:])
