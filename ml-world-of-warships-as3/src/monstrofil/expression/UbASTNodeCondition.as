package monstrofil.expression 
{
    public class UbASTNodeCondition extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeCondition(arg1:monstrofil.expression.IUbASTNode, arg2:monstrofil.expression.IUbASTNode, arg3:monstrofil.expression.IUbASTNode)
        {
            super();
            this.condition = arg1;
            this.trueChoice = arg2;
            this.falseChoice = arg3;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.CONDITION;
        }

        public var condition:monstrofil.expression.IUbASTNode;

        public var trueChoice:monstrofil.expression.IUbASTNode;

        public var falseChoice:monstrofil.expression.IUbASTNode;
    }
}
