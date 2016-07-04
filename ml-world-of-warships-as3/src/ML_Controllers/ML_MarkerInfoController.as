package ML_Controllers 
{
    import com.junkbyte.console.Cc;
    import lesta.components.Plane;
    import lesta.data.GameDelegate;
    import lesta.structs.Player;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import lesta.utils.GameInfoHolder;
    import ML_Models.ML_WebInfoHolder;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_MarkerInfoController extends UbController 
    {
        public static var lastAvatarEntityIdAdded = 0;
        public static var lastAvatarPythonIdAdded = 0;
        
        private var avatarName:String = "";
        public function ML_MarkerInfoController() 
        {
            super();
            
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);            
            scope.avatarId = lastAvatarEntityIdAdded;
            scope.avatarPythonId = lastAvatarPythonIdAdded;
            scope.isTorpedoShoot = false;
            scope.isFire = false;
            
            var player:Player = GameInfoHolder.instance.mapPlayers[lastAvatarPythonIdAdded];
            
            this.avatarName = player.name;
            var statistics:Object = ML_Models.ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
            if (!statistics.realData) {
                ML_Models.ML_WebInfoHolder.instance.evChanged.addCallback(this.onHolderChanged);
            }
            
            scope.statistics = statistics;
            GameDelegate.addCallBack("setFireStateMarker[" + lastAvatarPythonIdAdded + "]", this, this.setFireStateMarker);
            GameDelegate.addCallBack("setShootTorpedo[" + lastAvatarPythonIdAdded + "]", this, this.setFireStateMarker);
        }
        
        private function setFireStateMarker(arg1:Boolean):void{
            scope.isFire = arg1;
        }
        
        private function setTorpedoStateMarker(arg1:Boolean):void{
            scope.isTorpedoShoot = arg1;
        }
        
        private function onHolderChanged(playerName:String):void {
            if (playerName == this.avatarName) {
                var statistics:Object = ML_Models.ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
                ML_Models.ML_WebInfoHolder.instance.evChanged.removeCallback(this.onHolderChanged);
                scope.statistics = statistics;
            }
        }
        
    }

}