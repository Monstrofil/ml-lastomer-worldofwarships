package monstrofil.expression 
{
    public class UbASTNodeTerminal extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeTerminal(arg1:int, arg2:String)
        {
            super();
            this.type = arg1;
            this.value = arg2;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.TERMINAL;
        }

        public var type:int;

        public var value:String;
    }
}
