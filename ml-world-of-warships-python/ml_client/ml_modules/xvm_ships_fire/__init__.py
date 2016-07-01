__author__ = 'Monstrofil'

from Vehicle import Vehicle
import BWPersonality

def __setattr__(self, name, value):
    if name == 'burnIntensity':
        if BWPersonality.uiManager._UIManager__mainContext.battle:
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("setFireStateMarker[%s]"%self.owner, [value!=-1])

    super(Vehicle, self).__setattr__(name, value)

Vehicle.__setattr__ = __setattr__


