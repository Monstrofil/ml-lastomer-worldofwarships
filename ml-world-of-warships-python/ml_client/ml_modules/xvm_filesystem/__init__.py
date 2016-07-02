__author__ = 'shish'
import BWPersonality, sys, os
from gui.Scaleform.Battle import Battle
from os import listdir
from os.path import isfile, join
import ml_xvp.events
registerEvent = sys.modules['ml_xvp'].events.registerEvent

import ResMgr
resModPath = ResMgr.openSection('../paths.xml')['Paths'].values()[1]
relCachePath = resModPath.asString + '/gui/flash/'
print relCachePath

def getFilesList(id, folder, callback):
    relFolder = relCachePath + folder
    print [[folder + f for f in listdir(relFolder) if isfile(join(relFolder, f))]]
    BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call(callback, [[folder + f for f in listdir(relFolder) if isfile(join(relFolder, f))]])

@registerEvent(Battle, '__init__')
def onBattleStarted(*args, **params):
    BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.addExternalCallback("ML_getFilesList", getFilesList)