package monstrofil.unbound.bindings 
{
    import com.junkbyte.console.Cc;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import lesta.unbound.bindings.UbBinding;
    import lesta.unbound.core.UbCentral;
    import lesta.unbound.core.UbScope;
    import lesta.unbound.expression.IUbExpression;
    /**
     * ...
     * @author Monstrofil
     */
    public class UbNativeAssign extends UbBinding
    {
        
        private var displayObj:IUbExpression;
        private var displayProperty:IUbExpression;
        private var value:IUbExpression;
        
        public function UbNativeAssign() 
        {
            super();
        }
        
        public override function init(arg1:Vector.<IUbExpression>, arg2:Array, arg3:DisplayObject, arg4:UbScope, arg5:UbCentral):void
        {
            super.init(arg1, arg2, arg3, arg4, arg5);
            this.displayObj = arg1[0];
            this.displayProperty = arg1[1];
            this.value = arg1[2];
            
            this.displayObj.eval(arg4)[this.displayProperty.eval(arg4)] = this.value.eval(arg4);
        }

    }

}