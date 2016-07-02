package ML_Controllers 
{
    import com.junkbyte.console.Cc;
    import flash.events.Event;
    import flash.utils.Dictionary;
    import lesta.components.Health;
    import lesta.components.Relation;
    import lesta.constants.ComponentClass;
    import lesta.constants.PlayerRelation;
    import lesta.data.GameDelegate;
    import lesta.datahub.Collection;
    import lesta.datahub.Entity;
	import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import lesta.utils.DatahubToUbScopeExporter;
	
	/**
     * ...
     * @author Monstrofil
     */
    public class ML_TeamsHealthController extends UbController 
    {
        private var _teamHealth:Dictionary = new Dictionary()
        private var _enemyHealth:Dictionary = new Dictionary()
        
        public function ML_TeamsHealthController() 
        {
            super();	
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1); 
            
            GameDelegate.addCallBack("ML_onTeamsHpChanged", this, this.onHealthChanged)
            
            scope.alliedHealth = 0;
            scope.enemiesHealth = 0;
        }
        
        override public function free():void 
        {
            super.free();
            GameDelegate.removeCallBack(this);
        }
        
        private function onHealthChanged(alliedHealth:int, enemiesHealth:int) 
        {
            scope.alliedHealth = alliedHealth;
            scope.enemiesHealth = enemiesHealth;
        }
    }

}