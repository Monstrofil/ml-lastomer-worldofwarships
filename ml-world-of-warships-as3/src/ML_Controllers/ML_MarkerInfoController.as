package ML_Controllers 
{
    import com.junkbyte.console.Cc;
    import lesta.components.Plane;
    import lesta.constants.PlayerRelation;
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
        public static var lastAvatarEntityIdAdded:int = 0;
        public static var lastAvatarPythonIdAdded:int = 0;
        
        private var avatarName:String = "";
        private var player:Player = null;
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
            
            this.player = GameInfoHolder.instance.mapPlayers[lastAvatarPythonIdAdded];
            this.avatarName = this.player.name;
            
            var statistics:Object = ML_Models.ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
            
            Cc.log(statistics.real_data, this.avatarName);
            if (!statistics.real_data) {
                ML_Models.ML_WebInfoHolder.instance.evChanged.addCallback(this.onHolderChanged);
            }
            
            scope.statistics = statistics;
            GameDelegate.addCallBack("setFireStateMarker[" + lastAvatarPythonIdAdded + "]", this, this.setFireStateMarker);
            GameDelegate.addCallBack("setShootTorpedo[" + lastAvatarPythonIdAdded + "]", this, this.setTorpedoStateMarker);
        }
        
        private function setFireStateMarker(arg1:Boolean):void{
            scope.isFire = arg1;
        }
        
        private function setTorpedoStateMarker(arg1:Boolean):void {
            if(this.player.relation != PlayerRelation.ENEMY){
                scope.isTorpedoShoot = arg1;
            }
        }
        
        private function onHolderChanged(playerName:String):void {
            if (playerName == this.avatarName) {
                var statistics:Object = ML_Models.ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
                Cc.log("onHolderChanged", statistics.real_data, this.avatarName);
                ML_Models.ML_WebInfoHolder.instance.evChanged.removeCallback(this.onHolderChanged);
                scope.statistics = statistics;
                
                updateInScope("statistics");
            }
        }
        
    }

}