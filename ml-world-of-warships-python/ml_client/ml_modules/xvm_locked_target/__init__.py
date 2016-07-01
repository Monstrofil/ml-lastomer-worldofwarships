__author__ = 'Monstrofil'

import Avatar, BWPersonality
lastTarget = None

old_update = Avatar.Avatar.update
def onUpdate(self, dt):
    if BWPersonality.uiManager._UIManager__mainContext.battle:
        global lastTarget
        veh = self.targeting._ClientTargeting__weaponLocks.getTargetVehicle(self.selectedWeapon)
        if veh is None and lastTarget is None:
            return old_update(self, dt)
        if veh is not None and lastTarget == veh.owner:
            return old_update(self, dt)
        
        if veh is not None:
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("onMyTargetChanged", [veh.owner])
            lastTarget = veh.owner
        else:
            BWPersonality.uiManager._UIManager__mainContext.battle.infoHolder.call("onMyTargetChanged", [-1])
            lastTarget = None
    return old_update(self, dt)
Avatar.Avatar.update = onUpdate
