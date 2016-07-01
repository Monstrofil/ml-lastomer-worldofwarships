package monstrofil.expression 
{
    import __AS3__.vec.*;
    
    public class UbASTNodeFunctionCall extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeFunctionCall(arg1:monstrofil.expression.IUbASTNode, arg2:__AS3__.vec.Vector.<monstrofil.expression.IUbASTNode>=null)
        {
            super();
            this.source = arg1;
            this.args = arg2;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.FUNCTION_CALL;
        }

        public var source:monstrofil.expression.IUbASTNode;

        public var args:__AS3__.vec.Vector.<monstrofil.expression.IUbASTNode>;
    }
}
