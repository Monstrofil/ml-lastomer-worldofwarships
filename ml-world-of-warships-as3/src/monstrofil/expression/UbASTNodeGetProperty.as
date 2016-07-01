package monstrofil.expression 
{
    public class UbASTNodeGetProperty extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeGetProperty(arg1:monstrofil.expression.IUbASTNode, arg2:monstrofil.expression.IUbASTNode)
        {
            super();
            this.source = arg1;
            this.property = arg2;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.GET_PROPERTY;
        }

        public var source:monstrofil.expression.IUbASTNode;

        public var property:monstrofil.expression.IUbASTNode;
    }
}
