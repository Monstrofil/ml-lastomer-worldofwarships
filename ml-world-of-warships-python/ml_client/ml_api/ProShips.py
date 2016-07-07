# coding=utf-8
import os
__author__ = 'Monstrofil'
import ml_tools.WebWorker
import urllib, json, sys
g_webWorker = sys.modules['ml_tools'].WebWorker.g_webWorker
QueryLinkElement = sys.modules['ml_tools'].WebWorker.QueryLinkElement

try:
    import BigWorld
except:
    class BigWorld:
        @classmethod
        def server(cls):
            return ''

NA_SERVER = 'login.worldofwarships.com:20020'
RU_SERVER = 'login.worldofwarships.ru:20020'
EU_SERVER = 'login.worldofwarships.eu:20020'
ASIA_SERVER = 'login.worldofwarships.asia:20020'

class ProShips(object):
    def loadStatistics(self, usernames, callback):
        pureUsernames = [user[0] for user in usernames]
        nameWithShip = ['.'.join(user) for user in usernames]
        if BigWorld.server() == RU_SERVER:
            self.loadRU(nameWithShip, callback)
        elif BigWorld.server() == EU_SERVER:
            self.loadCOM(pureUsernames, callback, prefix='eu', appid='be3e454f976a3dfa4ad34603bbb303f0')
        elif BigWorld.server() == NA_SERVER:
            self.loadCOM(pureUsernames, callback, prefix='com', appid='afee1d10718a3beaccd79d0f60251e85')
        elif BigWorld.server() == ASIA_SERVER:
            self.loadCOM(pureUsernames, callback, prefix='asia')
        else:
            self.loadRU(nameWithShip, callback)

    def loadCOM(self, usernames, callback, prefix='ru', appid='demo'):
        responseBlock = {
            "id": "0",
            "name": "",
            "isHidden": "0",
            "clan_id": "0",
            "clan_tag": "",
            "karma": "0",
            "error": "actual_timer",
            "all_battles_count": "0",
            "all_wins": "0",
            "all_survived": "0",
            "all_damage": "0",
            "all_experience": "0",
            "all_rate": "0",
            "all_kill_dead": "0"
            }

        response = {}

        cleared_names = []
        for name in usernames:
            resp = responseBlock.copy()
            resp['name'] = name
            response[name] = resp

            if not (':' in name):
                cleared_names.append(name)
        usernames = cleared_names

        url = "http://api.worldoftanks.%s/wgn/account/list/" % prefix
        params = {
            'application_id':appid,
            'type':'exact',
            'search':','.join(usernames)
        }
        url = '?'.join([url, urllib.urlencode(params)])

        ids = []
        def usersCallback(data):
            data = json.loads(data)

            for player in data['data']:
                response[player['nickname']]['id'] = player['account_id']
                ids.append(player['account_id'])
            url = "http://api.worldoftanks.%s/wgn/clans/membersinfo/" % prefix
            params = {
                'application_id':appid,
                'fields':'account_id,account_name,clan.clan_id,clan.tag',
                'account_id':','.join(map(str, ids))
            }
            url = '?'.join([url, urllib.urlencode(params)])

            g_webWorker.queue.put(QueryLinkElement(url, clansCallback))

        def clansCallback(data):
            data = json.loads(data)
            for player in data['data'].values():
                if player is None:
                    continue
                response[player['account_name']]['clan_id'] = player['clan']['clan_id']
                response[player['account_name']]['clan_tag'] = player['clan']['tag']

            url = "http://api.worldofwarships.%s/wows/account/info/" % prefix
            params = {
                'application_id':appid,
                'fields':'nickname,statistics.pvp.battles,statistics.pvp.xp,statistics.pvp.wins,statistics.pvp.frags,statistics.pvp.battles,statistics.pvp.wins,statistics.pvp.frags,statistics.pvp.damage_dealt,statistics.pvp.survived_battles',
                'account_id':','.join(map(str, ids))
            }
            url = '?'.join([url, urllib.urlencode(params)])

            g_webWorker.queue.put(QueryLinkElement(url, statsCallback))

        def statsCallback(data):
            data = json.loads(data)
            for player in data['data'].values():
                if player is None:
                    continue

                name = player['nickname']
                response[name]['all_battles_count'] = player['statistics']['pvp']['battles']
                response[name]['all_wins'] = player['statistics']['pvp']['wins']
                response[name]['all_survived'] = player['statistics']['pvp']['survived_battles']
                response[name]['all_damage'] = player['statistics']['pvp']['damage_dealt']
                response[name]['all_rate'] = int(1.0 * player['statistics']['pvp']['xp'] / max(response[name]['all_battles_count'], 1))
                response[name]['all_experience'] = player['statistics']['pvp']['xp']

            callback(json.dumps({"data": response.values()}))

        g_webWorker.queue.put(QueryLinkElement(url, usersCallback))

    def loadRU(self, usernames, callback):
        url = "http://proships.ru/stat/api.php"
        params = {
            'nicks': ','.join(usernames)
        }
        url = '?'.join([url, urllib.urlencode(params)])
        g_webWorker.queue.put(QueryLinkElement(url, callback))

g_proShips = ProShips()