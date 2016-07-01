package monstrofil.expression 
{
    public class UbASTNodeList extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeList(arg1:Array)
        {
            super();
            this.items = arg1;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.LIST;
        }

        public var items:Array;
    }
}
