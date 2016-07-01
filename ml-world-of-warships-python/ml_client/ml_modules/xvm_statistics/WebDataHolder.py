# coding=utf-8
import json
import os, sys, BWPersonality, BigWorld
from pprint import pprint

import xvm_api.ProShips
g_proShips = sys.modules['ml_api'].ProShips.g_proShips
import ml_tools.ImageLoader
g_ImageLoader = sys.modules['ml_tools'].ImageLoader.g_ImageLoader
import xvm_xvp.events
registerEvent = sys.modules['xvm_xvp'].events.registerEvent

import ml_tools.ClientModules
PlayersInfo = sys.modules['ml_tools'].ClientModules.PlayersInfo

from gui.Scaleform.Battle import Battle

__author__ = 'Monstrofil'

class PlayerWebInfo(object):
    def __init__(self):
        self.name = ""
        self.inClan = False
        self.clanTag = ""
        self.clanIconPath = ""

    @property
    def fullName(self):
        if self.inClan:
            return '%s[%s]'%(self.name, self.clanTag)
        else:
            return self.name


class WebDataHolder(object):
    def __init__(self):
        self.playersWebData = {}
        self.players = []

    def onPlayersListUpdated(self):
        print 'onPlayersListUpdated'
        self.players = [player.name for player in PlayersInfo.iterPlayers()]


    def loadStatisticsCallback(self, data):
        pprint(data)
        def decode_proships_api(data): ##TODO: убрать костыль
            def is_int(num):
                try:
                    int(num)
                    return True
                except Exception:
                    return False

            def is_float(num):
                try:
                    float(num)
                    return True
                except Exception:
                    return False

            for player in data['data']:
                for j in player:
                    if is_int(player[j]):
                        player[j] = int(player[j])

                    elif is_float(player[j]):
                        player[j] = float(player[j])

            return data

        jsonData = decode_proships_api(json.loads(data))['data']

        for player in jsonData:
            info = PlayerWebInfo()
            info.name = player['name']
            info.clanTag = player['clan_tag']
            info.clanId = player['clan_id']
            info.clanIconPath = os.path.join(g_ImageLoader.root, str(player['clan_tag'])) if player['clan_id'] != 0 else ""
            info.inClan = False

            player['all_battles_count'] = max(1, player['all_battles_count'])
            info.all_battles_count = player['all_battles_count']
            info.all_wins = int(100.0 * player['all_wins'] / max(1, player['all_battles_count']))
            info.all_survived = 1.0 * player['all_survived'] / max(1, player['all_battles_count'])
            info.all_damage = int(player['all_damage'] / player['all_battles_count'])
            info.all_experience = int(player['all_experience'] / player['all_battles_count'])
            info.all_rate = int(player['all_rate'])
            info.all_kill_dead = player['all_kill_dead']

            if info.all_rate > 1850:
                all_rate_color = 'D042F3'
            elif info.all_rate>1400:
                all_rate_color = '00B9B9'
            elif info.all_rate>1000:
                all_rate_color = '4CC112'
            elif info.all_rate>750:
                all_rate_color = 'FFDC00'
            elif info.all_rate>600:
                all_rate_color = 'F56914'
            else:
                all_rate_color = 'EDEDED'
            info.all_rate_color = all_rate_color

            if info.all_wins > 60:
                all_wins_color = 'D042F3'
            elif info.all_wins>56:
                all_wins_color = '00B9B9'
            elif info.all_wins>50:
                all_wins_color = '4CC112'
            elif info.all_wins>48:
                all_wins_color = 'FFDC00'
            elif info.all_wins>45:
                all_wins_color = 'F56914'
            else:
                all_wins_color = 'EDEDED'
            info.all_wins_color = all_wins_color

            info.real_data = info.all_battles_count > 1


            print info.real_data, "updateWebData[%s]"%info.name
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("updateWebData[%s]"%info.name, [info])

            g_webDataHolder.playersWebData[info.name] = info

        def force_update_clans(i):
            if i >= len(g_webDataHolder.playersWebData.values()):
                return
            player = g_webDataHolder.playersWebData.values()[i]
            def clan_loaded_callback():
                BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("updateWebData[%s]"%player.name, [player])
                BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("updateWebDataEars[%s]"%player.name, [player])
                print player.real_data, "updateWebData[%s]"%player.name, 'clan_loaded_callback', player.name
                force_update_clans(i + 1)

            if player.clanId != 0:
                player.inClan = True
                g_ImageLoader.loadImage(player.clanId, clan_loaded_callback)
            else:
                force_update_clans(i + 1)

        force_update_clans(0)



g_webDataHolder = WebDataHolder()

@registerEvent(Battle, '__init__')
def onBattleStarted(*args, **params):
    print 'onBattleStarted'
    if len(g_webDataHolder.players) == 0: #Ooops! Some shit happened.
        g_webDataHolder.onPlayersListUpdated()

    g_proShips.loadStatistics(g_webDataHolder.players, g_webDataHolder.loadStatisticsCallback)

PlayersInfo.gPlayersListUpdated += g_webDataHolder.onPlayersListUpdated