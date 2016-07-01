package monstrofil.expression 
{
    import lesta.unbound.expression.IUbExpression;
    import monstrofil.expression.IUbExpression;
    public class UBExpressionTerminal extends monstrofil.expression.UbExpressionBase implements lesta.unbound.expression.IUbExpression, monstrofil.expression.IUbExpression
    {
        public function UBExpressionTerminal(arg1:monstrofil.expression.UbASTNodeTerminal)
        {
            super(arg1);
            this.type = arg1.type;
            this.value = arg1.value;
            var loc1:*=this.value.toLowerCase();
            if (this.type != monstrofil.expression.UbToken.T_IDENTIFIER) 
            {
                if (this.type != monstrofil.expression.UbToken.T_NUMBER) 
                {
                    if (this.type == monstrofil.expression.UbToken.T_STRING) 
                    {
                        this.returnProc = returnValueItself;
                    }
                }
                else 
                {
                    this.returnProc = returnValueAsNumber;
                }
            }
            else if (this.value != "String") 
            {
                var loc2:*=loc1;
                switch (loc2) 
                {
                    case "true":
                    {
                        this.returnProc = returnTrue;
                        break;
                    }
                    case "false":
                    {
                        this.returnProc = returnFalse;
                        break;
                    }
                    case "null":
                    {
                        this.returnProc = returnNull;
                        break;
                    }
                    case "$this":
                    {
                        this.returnProc = returnScope;
                        break;
                    }
                    default:
                    {
                        this.returnProc = returnPropertyFromScope;
                        addRequestedProperty(this.value);
                        break;
                    }
                }
            }
            else 
            {
                this.returnProc = returnValueItself;
            }
            return;
        }

        public override function eval(arg1:Object):*
        {
            return this.returnProc(this.value, arg1);
        }

        internal static function returnTrue(arg1:String, arg2:Object):Boolean
        {
            return true;
        }

        internal static function returnFalse(arg1:String, arg2:Object):Boolean
        {
            return false;
        }

        internal static function returnNull(arg1:String, arg2:Object):*
        {
            return null;
        }

        internal static function returnValueItself(arg1:String, arg2:Object):String
        {
            return arg1;
        }

        internal static function returnValueAsNumber(arg1:String, arg2:Object):Number
        {
            return Number(arg1);
        }

        internal static function returnScope(arg1:String, arg2:Object):Object
        {
            return arg2;
        }

        internal static function returnPropertyFromScope(arg1:String, arg2:Object):*
        {
            return arg2[arg1];
        }

        internal var value:String;

        internal var type:int;

        internal var returnProc:Function;
    }
}
