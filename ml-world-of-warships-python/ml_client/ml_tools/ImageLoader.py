import os
import sys
import ml_tools.FileLoader
FileLoader = sys.modules['ml_tools'].FileLoader.FileLoader
QueryFileElement = sys.modules['ml_tools'].FileLoader.QueryFileElement

__author__ = 'Monstrofil'

NA_SERVER = 'login.worldofwarships.com:20020'
RU_SERVER = 'login.worldofwarships.ru:20020'
EU_SERVER = 'login.worldofwarships.eu:20020'

import BigWorld

class ImageLoader(FileLoader):
    def __init__(self):
        import ResMgr
        resModPath = ResMgr.openSection('../paths.xml')['Paths'].values()[1]
        relCachePath = resModPath.asString + '/gui/__cache__'
        absCachePath = os.path.abspath(relCachePath)
        if not os.path.exists(absCachePath):
            os.makedirs(absCachePath)
        super(ImageLoader, self).__init__(absCachePath)

    def loadImage(self, clan_id, callback=None):
        prefix = "ru"
        if BigWorld.server() == RU_SERVER:
            prefix = "ru"
        elif BigWorld.server() == EU_SERVER:
            prefix = "eu"
        elif BigWorld.server() == NA_SERVER:
            prefix = "na"
        else:
            prefix = "ru"


        url = "http://" + prefix + ".wargaming.net/clans/media/clans/emblems/cl_%s/%s/emblem_24x24.png" % (str(clan_id)[-3:], clan_id)
        self.__loadImage('%s.png' % clan_id, url, callback)

    def __loadImage(self, name, url, callback=None):
        tmp = QueryFileElement(name, url, callback)
        self.queue.put(tmp)

g_ImageLoader = ImageLoader()
g_ImageLoader.start()