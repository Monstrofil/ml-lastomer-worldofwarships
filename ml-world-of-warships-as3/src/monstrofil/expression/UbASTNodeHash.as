package monstrofil.expression 
{
    import __AS3__.vec.*;
    
    public class UbASTNodeHash extends Object implements monstrofil.expression.IUbASTNode
    {
        public function UbASTNodeHash(arg1:__AS3__.vec.Vector.<monstrofil.expression.UbASTHashPair>)
        {
            super();
            this.items = arg1;
            return;
        }

        public function get astType():int
        {
            return monstrofil.expression.UbASTNodeType.HASH;
        }

        public var items:__AS3__.vec.Vector.<monstrofil.expression.UbASTHashPair>;
    }
}
