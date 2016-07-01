package monstrofil.expression 
{
    public class UbASTNodeBinaryOp extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeBinaryOp(arg1:monstrofil.expression.IUbASTNode, arg2:String, arg3:monstrofil.expression.IUbASTNode)
        {
            super();
            this.operator = arg2;
            this.firstOperand = arg1;
            this.secondOperand = arg3;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.BINARY_OPERATION;
        }

        public var operator:String;

        public var firstOperand:monstrofil.expression.IUbASTNode;

        public var secondOperand:monstrofil.expression.IUbASTNode;
    }
}
