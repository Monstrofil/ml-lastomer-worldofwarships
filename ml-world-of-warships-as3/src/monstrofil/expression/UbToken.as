package monstrofil.expression 
{
    public class UbToken extends Object
    {
        public function UbToken(arg1:int, arg2:String)
        {
            super();
            this.type = arg1;
            this.value = arg2;
            return;
        }

        public function toString():String
        {
            return "[token: " + this.type + ", " + this.value + "]";
        }

        public static const S_BITWISE_R_SHIFT:String=">>";

        public static const I_IN:String="in";

        public static const T_IDENTIFIER:int=1;

        public static const T_STRING:int=2;

        public static const T_NUMBER:int=4;

        public static const T_SYMBOL:int=8;

        public static const S_LEFT_BRACKET:String="[";

        public static const S_RIGHT_BRACKET:String="]";

        public static const S_LEFT_CURLY:String="{";

        public static const S_RIGHT_CURLY:String="}";

        public static const S_LEFT_BRACE:String="(";

        public static const S_RIGHT_BRACE:String=")";

        public static const S_DOT:String=".";

        public static const S_NOT:String="!";

        public static const S_ADD:String="+";

        public static const S_NEG:String="-";

        public static const S_MUL:String="*";

        public static const S_DIV:String="/";

        public static const S_MOD:String="%";

        public static const S_AND:String="&&";

        public static const S_OR:String="||";

        public static const S_EQ:String="==";

        public static const S_NEQ:String="!=";

        public static const S_MORE:String=">";

        public static const S_LESS:String="<";

        public static const S_EQ_MORE:String=">=";

        public static const S_EQ_LESS:String="<=";

        public static const S_TERNARY_COND:String="?";

        public static const S_TERNARY_ALT:String=":";

        public static const S_COMMA:String=",";

        public static const S_BITWISE_AND:String="&";

        public static const S_BITWISE_OR:String="|";

        public static const S_BITWISE_XOR:String="^";

        public static const S_BITWISE_NOT:String="~";

        public static const S_BITWISE_L_SHIFT:String="<<";

        public var value:String;

        public var type:int;
    }
}
