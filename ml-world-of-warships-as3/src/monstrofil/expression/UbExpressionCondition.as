package monstrofil.expression 
{
    public class UbExpressionCondition extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UbExpressionCondition(arg1:monstrofil.expression.UbASTNodeCondition)
        {
            super(arg1);
            this.conditionProc = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.condition);
            this.trueChoice = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.trueChoice);
            this.falseChoice = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.falseChoice);
            addRequestedPropertiesOfExpression(this.conditionProc);
            addRequestedPropertiesOfExpression(this.trueChoice);
            addRequestedPropertiesOfExpression(this.falseChoice);
            return;
        }

        public override function eval(arg1:Object):*
        {
            return this.conditionProc.eval(arg1) ? this.trueChoice.eval(arg1) : this.falseChoice.eval(arg1);
        }

        internal var conditionProc:monstrofil.expression.IUbExpression;

        internal var trueChoice:monstrofil.expression.IUbExpression;

        internal var falseChoice:monstrofil.expression.IUbExpression;
    }
}
