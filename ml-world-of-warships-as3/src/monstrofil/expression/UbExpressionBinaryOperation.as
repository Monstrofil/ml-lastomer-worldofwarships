package monstrofil.expression 
{
    import lesta.unbound.expression.IUbExpression;
    public class UbExpressionBinaryOperation extends monstrofil.expression.UbExpressionBase implements lesta.unbound.expression.IUbExpression, monstrofil.expression.IUbExpression
    {
        public function UbExpressionBinaryOperation(arg1:monstrofil.expression.UbASTNodeBinaryOp)
        {
            super(arg1);
            this.firstOperand = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.firstOperand);
            this.secondOperand = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.secondOperand);
            this.operator = arg1.operator;
            this.returnProc = methodsByToken[this.operator];
            addRequestedPropertiesOfExpression(this.firstOperand);
            addRequestedPropertiesOfExpression(this.secondOperand);
            return;
        }

        public override function eval(arg1:Object):*
        {
            return this.returnProc(this.firstOperand.eval(arg1), this.secondOperand.eval(arg1));
        }

        public static function addition(arg1:*, arg2:*):*
        {
            return arg1 + arg2;
        }

        public static function substraction(arg1:*, arg2:*):*
        {
            return arg1 - arg2;
        }

        public static function multiplication(arg1:*, arg2:*):*
        {
            return arg1 * arg2;
        }

        public static function division(arg1:*, arg2:*):Number
        {
            return arg1 / arg2;
        }

        public static function modulus(arg1:*, arg2:*):*
        {
            return arg1 % arg2;
        }

        public static function and(arg1:*, arg2:*):Boolean
        {
            return arg1 && arg2;
        }

        public static function or(arg1:*, arg2:*):*
        {
            return arg1 || arg2;
        }

        public static function equals(arg1:*, arg2:*):Boolean
        {
            return arg1 == arg2;
        }

        public static function notEquals(arg1:*, arg2:*):Boolean
        {
            return !(arg1 == arg2);
        }

        public static function greaterThan(arg1:*, arg2:*):Boolean
        {
            return arg1 > arg2;
        }

        public static function lessThan(arg1:*, arg2:*):Boolean
        {
            return arg1 < arg2;
        }

        public static function notGreaterThan(arg1:*, arg2:*):Boolean
        {
            return arg1 <= arg2;
        }

        public static function notLessThan(arg1:*, arg2:*):Boolean
        {
            return arg1 >= arg2;
        }

        public static function isIn(arg1:*, arg2:*):Boolean
        {
            if (arg2 == null) 
            {
                return false;
            }
            return arg2 is Array ? arg2.indexOf(arg1) > -1 : arg1 in arg2;
        }

        public static function bitwiseAnd(arg1:*, arg2:*):int
        {
            return arg1 & arg2;
        }

        public static function bitwiseOr(arg1:*, arg2:*):int
        {
            return arg1 | arg2;
        }

        public static function bitwiseXor(arg1:*, arg2:*):int
        {
            return arg1 ^ arg2;
        }

        public static function bitwiseLeftShift(arg1:*, arg2:*):int
        {
            return arg1 << arg2;
        }

        public static function bitwiseRightShift(arg1:*, arg2:*):int
        {
            return arg1 >> arg2;
        }

        internal static function init():int
        {
            methodsByToken[monstrofil.expression.UbToken.S_ADD] = addition;
            methodsByToken[monstrofil.expression.UbToken.S_NEG] = substraction;
            methodsByToken[monstrofil.expression.UbToken.S_MUL] = multiplication;
            methodsByToken[monstrofil.expression.UbToken.S_DIV] = division;
            methodsByToken[monstrofil.expression.UbToken.S_MOD] = modulus;
            methodsByToken[monstrofil.expression.UbToken.S_AND] = and;
            methodsByToken[monstrofil.expression.UbToken.S_OR] = or;
            methodsByToken[monstrofil.expression.UbToken.S_EQ] = equals;
            methodsByToken[monstrofil.expression.UbToken.S_NEQ] = notEquals;
            methodsByToken[monstrofil.expression.UbToken.S_MORE] = greaterThan;
            methodsByToken[monstrofil.expression.UbToken.S_LESS] = lessThan;
            methodsByToken[monstrofil.expression.UbToken.S_EQ_LESS] = notGreaterThan;
            methodsByToken[monstrofil.expression.UbToken.S_EQ_MORE] = notLessThan;
            methodsByToken[monstrofil.expression.UbToken.I_IN] = isIn;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_AND] = bitwiseAnd;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_OR] = bitwiseOr;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_XOR] = bitwiseXor;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_L_SHIFT] = bitwiseLeftShift;
            methodsByToken[monstrofil.expression.UbToken.S_BITWISE_R_SHIFT] = bitwiseRightShift;
            return 0;
        }

        
        {
            inited = init();
        }

        public static const methodsByToken:Object={};

        internal var firstOperand:monstrofil.expression.IUbExpression;

        internal var secondOperand:monstrofil.expression.IUbExpression;

        internal var operator:String;

        internal var returnProc:Function;

        internal static var inited:int;
    }
}
