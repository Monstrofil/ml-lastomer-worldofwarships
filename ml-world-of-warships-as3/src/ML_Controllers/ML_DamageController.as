package ML_Controllers 
{
    import com.junkbyte.console.Cc;
    import flash.external.ExternalInterface;
    import lesta.data.GameDelegate;
    import lesta.structs.GunStateInfo;
    import lesta.structs.Player;
    import lesta.structs.WeaponsInfo;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import lesta.utils.GameInfoHolder;
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_DamageController extends UbController
    {
        private var damageInfo:OwnDamageInfo = new OwnDamageInfo();
        public function ML_DamageController() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);
            scope.copyDataFrom(this.damageInfo);
            
            GameDelegate.addCallBack("onVehicleDamagedByMe", this, this.onVehicleDamagedByMe);
            GameDelegate.addCallBack("onMeDamagedByVehicle", this, this.onMeDamagedByVehicle);
        }
        
        private function onVehicleDamagedByMe(damage:int, avatarId:int, ammoType:String, shoterData:String):void {
            var damagedPlayer:Player = GameInfoHolder.instance.mapPlayers[avatarId];
            this.damageInfo.onVehicleDamaged(damage, damagedPlayer, ammoType, shoterData);
            
            scope.copyDataFrom(this.damageInfo);
        }
        
        private function onMeDamagedByVehicle(damage:int, avatarId:int, ammoType:String, shoterData:String):void {
            var damagerPlayer:Player = GameInfoHolder.instance.mapPlayers[avatarId];
            this.damageInfo.onSelfDamaged(damage, damagerPlayer, ammoType, shoterData);
            
            Cc.info("onSelfDamaged", damage, avatarId, damagerPlayer);
            
            scope.copyDataFrom(this.damageInfo);
        }
    }
}
import lesta.structs.Player;

class OwnDamageInfo extends Object {
    public var totalDamage:int = 0;
    public var damagedEntities:Array = [];
    public var damagedMeEntities:Array = [];
    public function OwnDamageInfo() {
        super();
    }
    
    public function onVehicleDamaged(damage:int, player:Player, ammoType:String, shoterData:String):void {
        this.totalDamage += damage;
        if (this.damagedEntities.length > 0 && (this.damagedEntities[0].player.name == player.name)) {
            this.damagedEntities[0].damage += damage;
            this.damagedEntities[0].last = damage;
            this.damagedEntities[0].shots += 1;
            
        }
        else {
            this.damagedEntities.unshift( { "damage": damage, "player": player, 'ammoType':ammoType, 'shoterData':shoterData, 'shots':1, 'last': 0 } );
        }
        
        if (this.damagedEntities.length > 5) {
            this.damagedEntities.pop();
        }
    }
    
    public function onSelfDamaged(damage:int, player:Player, ammoType:String, shoterData:String):void {
        if (this.damagedMeEntities.length > 0 && (this.damagedMeEntities[0].player.name == player.name)) {
            this.damagedMeEntities[0].damage += damage;
        }
        else {
            this.damagedMeEntities.unshift( { "damage": damage, "player": player, 'ammoType':ammoType, 'shoterData':shoterData } );
        }
        
        if (this.damagedMeEntities.length > 5) {
            this.damagedMeEntities.pop();
        }
    }
}

