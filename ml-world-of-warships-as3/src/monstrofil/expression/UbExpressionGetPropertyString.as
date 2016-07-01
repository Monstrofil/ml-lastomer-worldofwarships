package monstrofil.expression 
{
    public class UbExpressionGetPropertyString extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UbExpressionGetPropertyString(arg1:monstrofil.expression.UbASTNodeGetPropertyString)
        {
            super(arg1);
            this.property = arg1.property;
            this.fromProc = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.source);
            addRequestedProperty(this.property);
            addRequestedPropertiesOfExpression(this.fromProc);
            return;
        }

        public override function eval(arg1:Object):*
        {
            var loc1:*=this.fromProc.eval(arg1);
            return loc1 ? loc1[this.property] : null;
        }

        internal var property:String;

        internal var fromProc:monstrofil.expression.IUbExpression;
    }
}
