package monstrofil.controllers 
{
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import lesta.dialogs.battle_window_controllers.EarsController;
    import lesta.dialogs.battle_window_controllers.uss_controllers.ControllerBattleStats;
    import lesta.unbound.core.UbController;
    import lesta.unbound.expression.IUbExpression;
    import com.junkbyte.console.Cc;
    import scaleform.clik.data.DataProvider;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class EntitiesController extends ControllerBattleStats
    {
        public function EntitiesController() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>):void
        {
            super.init(arg1);
            
            var timer:Timer = new Timer(500);
            timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            timer.start();
            return;
        }
        
        public function onTimer(e:Event):void {
            updateInScope("allies");
            updateInScope("enemies");
        }
    }

}