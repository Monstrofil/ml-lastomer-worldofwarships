package monstrofil.unbound
{
    import lesta.unbound.core.UbCentral;
    import lesta.unbound.expression.IUbExpression;
    import lesta.unbound.layout.UbBlockFactory;
    import monstrofil.expression.UbExpressionCompiler;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class CustomUbBlockFactory extends UbBlockFactory 
    {
        
        public function CustomUbBlockFactory(param0:UbCentral) 
        {
            super(param0);
        }
        
        public override function parseBindingExpression(arg1:String):lesta.unbound.expression.IUbExpression
        {
            return expressionCompiler.compile(arg1);
        }
        
        public var expressionCompiler:UbExpressionCompiler = new UbExpressionCompiler();
    }

}