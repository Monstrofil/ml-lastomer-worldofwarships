package monstrofil.expression 
{
    import flash.utils.*;
    import monstrofil.expression.IUbASTNode;
    import lesta.unbound.expression.IUbExpression;
    
    public class UbExpressionBase extends Object implements lesta.unbound.expression.IUbExpression, monstrofil.expression.IUbExpression
    {
        public function UbExpressionBase(arg1:monstrofil.expression.IUbASTNode)
        {
            this._requestedProps = new flash.utils.Dictionary();
            super();
            this._astType = arg1.astType;
            return;
        }

        public function eval(arg1:Object):*
        {
            throw new Error("Can\'t evaluate UbExpressionBase!");
        }

        public function get requestedProps():flash.utils.Dictionary
        {
            return this._requestedProps;
        }

        public function get astType():int
        {
            return this._astType;
        }

        public function get isConstant():Boolean
        {
            var loc1:*=null;
            if (this._numUsedProps < 0) 
            {
                this._numUsedProps = 0;
                var loc2:*=0;
                var loc3:*=this._requestedProps;
                for (loc1 in loc3) 
                {
                    var loc4:*;
                    var loc5:*=((loc4 = this)._numUsedProps + 1);
                    loc4._numUsedProps = loc5;
                }
            }
            return this._numUsedProps == 0;
        }

        protected function addRequestedProperty(arg1:String):void
        {
            var loc1:*=0;
            if (specialContainerProps.indexOf(arg1) != -1) 
            {
                loc1 = int(this._requestedProps[arg1]);
                this._requestedProps[arg1] = loc1 + 1;
            }
            else 
            {
                this._requestedProps[arg1] = 1;
            }
            this._numUsedProps = -1;
            return;
        }

        protected function addRequestedPropertiesOfExpression(arg1:monstrofil.expression.IUbExpression):void
        {
            copyProps(this._requestedProps, arg1.requestedProps);
            this._numUsedProps = -1;
            return;
        }

        internal static function copyProps(arg1:flash.utils.Dictionary, arg2:flash.utils.Dictionary):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                if (specialContainerProps.indexOf(loc1) == -1) 
                {
                    arg1[loc1] = arg2[loc1];
                    continue;
                }
                arg1[loc1] = Math.max(int(arg1[loc1]), int(arg2[loc1]));
            }
            return;
        }

        public static const specialContainerProps:Array=["$parent", "$root"];

        protected var _astType:int=-1;

        protected var _requestedProps:flash.utils.Dictionary;

        protected var _dump:Function;

        protected var _numUsedProps:int=-1;
    }
}
