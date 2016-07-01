package monstrofil.expression 
{
    public class UBExpressionUnaryOperation extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UBExpressionUnaryOperation(arg1:monstrofil.expression.UbASTNodeUnaryOp)
        {
            super(arg1);
            this.operand = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.operand);
            this.returnProc = methodsByToken[arg1.operator];
            addRequestedPropertiesOfExpression(this.operand);
            return;
        }

        public override function eval(arg1:Object):*
        {
            return this.returnProc(this.operand.eval(arg1));
        }

        public static function negative(arg1:*):*
        {
            return -arg1;
        }

        public static function not(arg1:*):Boolean
        {
            return !arg1;
        }

        public static function bitwiseNotot(arg1:*):int
        {
            return ~arg1;
        }

        internal static function init():int
        {
            methodsByToken[monstrofil.expression.UbToken.S_NEG] = negative;
            methodsByToken[monstrofil.expression.UbToken.S_NOT] = not;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_NOT] = bitwiseNotot;
            return 0;
        }

        
        {
            inited = init();
        }

        public static const methodsByToken:Object={};

        internal var operand:monstrofil.expression.IUbExpression;

        internal var returnProc:Function;

        internal static var inited:int;
    }
}
