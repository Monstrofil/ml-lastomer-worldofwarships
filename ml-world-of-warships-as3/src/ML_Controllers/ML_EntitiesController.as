package ML_Controllers 
{
    import lesta.constants.ComponentClass;
    import lesta.datahub.Collection;
    import lesta.datahub.SortedCollection;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
	/**
     * ...
     * @author Monstrofil
     */
    public class ML_EntitiesController extends UbController
    {
        
        public function ML_EntitiesController() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);
            var collection:Collection = XVMDatahubController.xvmDataHub.getCollection(ComponentClass.avatar).child("team");
            var teamCollection:Collection = collection.child(true).child("sortedAlive");
            var enemyCollection:Collection = collection.child(false).child("sortedAlive");
            
            scope.team = teamCollection.items;
            scope.enemy = enemyCollection.items;
            
            teamCollection.evMoved.addCallback(function():void {
                updateInScope("team");
            });
            enemyCollection.evMoved.addCallback(function():void {
                updateInScope("enemy");
            });
            
        }
    }

}