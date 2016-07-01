__author__ = 'Monstrofil'

import os
import ResMgr
resModPath = ResMgr.openSection('../paths.xml')['Paths'].values()[1]
directory = resModPath.asString + '/scripts/client/ml_modules/'
for module in [x[1] for x in os.walk(directory)][0]:
    __import__('ml_modules.%s'%module)