package ML_Controllers 
{
    import com.junkbyte.console.Cc;
    import flash.external.ExternalInterface;
    import lesta.data.GameDelegate;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import lesta.utils.GameInfoHolder;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_CurrentTargetController extends UbController 
    {
        
        public function ML_CurrentTargetController() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);
            scope.target = null;
            GameDelegate.addCallBack("onMyTargetChanged", this, this.onTargetChanged);
        }
        
        private function onTargetChanged(player_id:int):void {
            if(player_id != -1){
                scope.target = GameInfoHolder.instance.mapPlayers[player_id];
            }
            else {
                scope.target = null;
            }
            
            updateInScope('target');
        }
        
    }

}