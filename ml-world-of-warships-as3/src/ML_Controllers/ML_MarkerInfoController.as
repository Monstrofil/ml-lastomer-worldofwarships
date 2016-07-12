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
        private var consumablesController:ConsumablesController;
        
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
            
            this.consumablesController = new ConsumablesController(lastAvatarPythonIdAdded);
            scope.comsumables = consumablesController.consumables; 
            
            this.consumablesController.evChanged.addCallback(function(...rest):void {
               scope.comsumables = consumablesController.consumables; 
            });
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
import com.junkbyte.console.Cc;
import lesta.utils.GameInfoHolder;
import lesta.utils.Invoker;
import lesta.data.GameDelegate;

class ConsumablesController {
    public var consumables:Array = [];
    
    public function ConsumablesController(id:int) {
        super()
        this.evChanged.parent = this;
        
        this.setupCallbacks(id);
    }
    
    private function setupCallbacks(id:int):void {
        //GameDelegate.addCallBack("onConsumableUsed[" + id + "]", this, this.onConsumableUsed);
        Cc.log('onConsumableUsed[" + id + "]"');
    }
    
    private function onConsumableUsed(name:String, timeLeft:Number) {
        GameInfoHolder.instance.serverTimeDelta = 0;
        this.consumables.push( { 'name':name, 'timeLeft':(timeLeft * 1000 + new Date().time) / 1000 } );
        Cc.log('onConsumableUsed[" + id + "]"', name, timeLeft, new Date().time, (timeLeft * 1000 + new Date().time) / 1000, GameInfoHolder.instance.serverTimeDelta);
        
        this.evChanged.invoke([this]);
    }
    
    public var evChanged:Invoker = new Invoker();
}