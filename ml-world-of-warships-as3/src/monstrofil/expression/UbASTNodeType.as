package monstrofil.expression 
{
    public class UbASTNodeType extends Object
    {
        public function UbASTNodeType()
        {
            super();
            return;
        }

        public static const NONE:int=-1;

        public static const BINARY_OPERATION:int=0;

        public static const CONDITION:int=1;

        public static const FUNCTION_CALL:int=2;

        public static const GET_PROPERTY:int=3;

        public static const GET_PROPERTY_STRING:int=4;

        public static const HASH:int=5;

        public static const LIST:int=6;

        public static const TERMINAL:int=7;

        public static const UNARY_OPERATION:int=8;
    }
}
