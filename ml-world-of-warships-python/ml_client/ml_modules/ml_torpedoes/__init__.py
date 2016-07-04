__author__ = 'shish'
import Vehicle, BWPersonality
import BigWorld


old_shoot = Vehicle.Vehicle.shootTorpedo
def new_shoot(self, gunID, randDir, salvoID):
    print self, gunID, randDir, salvoID, "TORPEDOOO"
    command = "setShootTorpedo[%s]"%self.owner
    print command
    BWPersonality.uiManager._UIManager__mainContext.flash.call(command, [True])

    def removeTorpedoMarker(command):
        print command, "REMOVE"
        BWPersonality.uiManager._UIManager__mainContext.flash.call(command, [False])

    BigWorld.callback(3, lambda: removeTorpedoMarker(command))

    old_shoot(self, gunID, randDir, salvoID)
Vehicle.Vehicle.shootTorpedo = new_shoot