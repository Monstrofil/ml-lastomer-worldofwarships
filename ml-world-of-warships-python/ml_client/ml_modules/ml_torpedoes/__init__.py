__author__ = 'shish'
import Vehicle, BWPersonality
import BigWorld

old_shoot = Vehicle.Vehicle.shootTorpedo
def new_shoot(self, gunID, randDir, salvoID):
    command = "setShootTorpedo[%s]"%self.owner
    BWPersonality.uiManager._UIManager__mainContext.flash.call(command, [True])
    def removeTorpedoMarker(command):
        BWPersonality.uiManager._UIManager__mainContext.flash.call(command, [False])

    BigWorld.callback(5, lambda: removeTorpedoMarker(command))
    old_shoot(self, gunID, randDir, salvoID)
Vehicle.Vehicle.shootTorpedo = new_shoot