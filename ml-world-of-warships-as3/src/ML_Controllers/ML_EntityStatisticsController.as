package ML_Controllers 
{
    import com.junkbyte.console.Cc;
	import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import ML_Models.ML_WebInfoHolder;
	
	/**
     * ...
     * @author Monstrofil
     */
    public class ML_EntityStatisticsController extends UbController 
    {
        private var avatarName:String = "";
        public function ML_EntityStatisticsController() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);
            
            this.avatarName = arg1[0].eval(this.scope);
            
            Cc.log(this.avatarName, "Entity");
            
            var statistics:Object = ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
            Cc.log(statistics.real_data, this.avatarName);
            if (!statistics.real_data) {
                ML_WebInfoHolder.instance.evChanged.addCallback(this.onHolderChanged);
            }
            
            scope.statistics = statistics;
        }
        
        private function onHolderChanged(playerName:String):void {
            if (playerName == this.avatarName) {
                var statistics:Object = ML_WebInfoHolder.instance.getStatisticsObjectIfExists(this.avatarName);
                Cc.log("onHolderChangedEar", statistics.real_data, this.avatarName);
                ML_Models.ML_WebInfoHolder.instance.evChanged.removeCallback(this.onHolderChanged);
                scope.statistics = statistics;
                
                updateInScope("statistics");
            }
        }
        
    }

}