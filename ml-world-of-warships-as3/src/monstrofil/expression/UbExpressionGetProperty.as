package monstrofil.expression 
{
    public class UbExpressionGetProperty extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UbExpressionGetProperty(arg1:monstrofil.expression.UbASTNodeGetProperty)
        {
            super(arg1);
            this.fromProc = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.source);
            this.propProc = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.property);
            addRequestedPropertiesOfExpression(this.fromProc);
            addRequestedPropertiesOfExpression(this.propProc);
            return;
        }

        public override function eval(arg1:Object):*
        {
            var loc1:*=this.fromProc.eval(arg1);
            return loc1 ? loc1[this.propProc.eval(arg1)] : null;
        }

        internal var fromProc:monstrofil.expression.IUbExpression;

        internal var propProc:monstrofil.expression.IUbExpression;
    }
}
