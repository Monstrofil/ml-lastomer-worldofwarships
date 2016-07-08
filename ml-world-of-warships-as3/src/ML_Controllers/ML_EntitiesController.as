package ML_Controllers 
{
    import lesta.constants.ComponentClass;
    import lesta.datahub.Collection;
    import lesta.datahub.Entity;
    import lesta.datahub.SortedCollection;
    import lesta.structs.Player;
    import lesta.structs.ShipInfo;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import lesta.utils.GameInfoHolder;
    import ML_Models.ML_WebInfoHolder;
    import ML_Models.ShipInfoC;
    import ML_Models.Statistics;
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
            
            for each(var e:Entity in teamCollection.items) {
               e.addComponent(ML_WebInfoHolder.instance.getStatisticsComponent(e.avatar.name)); 
               for each(var player:Player in GameInfoHolder.instance.listAlliedPlayers)
               {
                    if (player.name == e.avatar.name) {
                        var shipInfo:ShipInfoC = new ShipInfoC();
                        shipInfo.setShipInfo(player.shipParams);
                        e.addComponent(shipInfo);
                        break;
                    }
               }
            }
            
            for each(var e:Entity in enemyCollection.items) {
               e.addComponent(ML_WebInfoHolder.instance.getStatisticsComponent(e.avatar.name)); 
               
                for each(var player:Player in GameInfoHolder.instance.listEnemyPlayers)
               {
                    if (player.name == e.avatar.name) {
                        var shipInfo:ShipInfoC = new ShipInfoC();
                        shipInfo.setShipInfo(player.shipParams);
                        e.addComponent(shipInfo);
                        break;
                    }
               }
            }
            
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