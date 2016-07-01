package monstrofil.expression 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public class UbLexer extends Object
    {
        public function UbLexer()
        {
            super();
            return;
        }

        public function tokenize(arg1:String):__AS3__.vec.Vector.<monstrofil.expression.UbToken>
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.init();
            arg1 = arg1.concat(" ");
            var loc1:*=new Vector.<monstrofil.expression.UbToken>();
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg1.charAt(loc3);
                loc5 = loc3 < (loc2 - 1) ? loc4 + arg1.charAt(loc3 + 1) : loc4;
                var loc7:*=this.currentTokenType;
                switch (loc7) 
                {
                    case monstrofil.expression.UbToken.T_IDENTIFIER:
                    {
                        if (loc4 >= "a" && loc4 <= "z" || loc4 >= "A" && loc4 <= "Z" || loc4 == "_" || loc4 == "$" || loc4 >= "0" && loc4 <= "9") 
                        {
                            if (loc4 == "$" && this.paragraphUsed) 
                            {
                                throw new Error("UbLexer -- error parsing expression " + arg1 + ", cannot use $ twice in identifier at position " + loc3);
                            }
                            this.currentTokenValue = this.currentTokenValue + loc4;
                        }
                        else 
                        {
                            loc1.push(new monstrofil.expression.UbToken(this.currentTokenType, this.currentTokenValue));
                            this.currentTokenType = -1;
                            --loc3;
                        }
                        break;
                    }
                    case monstrofil.expression.UbToken.T_NUMBER:
                    {
                        if (loc4 >= "0" && loc4 <= "9" || this.numberIsHex && (loc4 >= "A" && loc4 <= "F" || loc4 >= "a" && loc4 <= "f")) 
                        {
                            this.currentTokenValue = this.currentTokenValue + loc4;
                        }
                        else if (loc4 == "." && !this.dotUsedInNumber && !this.numberIsHex) 
                        {
                            this.dotUsedInNumber = true;
                            this.currentTokenValue = this.currentTokenValue + loc4;
                        }
                        else if (loc4 == "x" && this.currentTokenValue == "0") 
                        {
                            this.numberIsHex = true;
                            this.currentTokenValue = this.currentTokenValue + loc4;
                        }
                        else 
                        {
                            loc6 = this.currentTokenValue.charAt((this.currentTokenValue.length - 1));
                            if (this.dotUsedInNumber && loc6 == "." || this.numberIsHex && loc6 == "x") 
                            {
                                throw new Error("UbLexer -- error parsing expression " + arg1 + ", invalid number at position " + loc3);
                            }
                            loc1.push(new monstrofil.expression.UbToken(this.currentTokenType, this.currentTokenValue));
                            this.currentTokenType = -1;
                            --loc3;
                        }
                        break;
                    }
                    case monstrofil.expression.UbToken.T_STRING:
                    {
                        if (this.stringEscape) 
                        {
                            this.currentTokenValue = this.currentTokenValue + loc4;
                            this.stringEscape = false;
                        }
                        else if (loc4 != "\\") 
                        {
                            if (loc4 == this.stringOpening) 
                            {
                                loc1.push(new monstrofil.expression.UbToken(this.currentTokenType, this.currentTokenValue));
                                this.currentTokenType = -1;
                            }
                            else 
                            {
                                this.currentTokenValue = this.currentTokenValue + loc4;
                            }
                        }
                        else 
                        {
                            this.stringEscape = true;
                        }
                        break;
                    }
                    default:
                    {
                        if (loc5 in symbols) 
                        {
                            loc1.push(new monstrofil.expression.UbToken(monstrofil.expression.UbToken.T_SYMBOL, loc5));
                            ++loc3;
                        }
                        else if (loc4 in symbols) 
                        {
                            loc1.push(new monstrofil.expression.UbToken(monstrofil.expression.UbToken.T_SYMBOL, loc4));
                        }
                        else if (loc4 >= "a" && loc4 <= "z" || loc4 >= "A" && loc4 <= "Z" || loc4 == "_" || loc4 == "$") 
                        {
                            this.currentTokenType = monstrofil.expression.UbToken.T_IDENTIFIER;
                            this.currentTokenValue = loc4;
                            this.paragraphUsed = loc4 == "$";
                        }
                        else if (loc4 >= "0" && loc4 <= "9") 
                        {
                            this.currentTokenType = monstrofil.expression.UbToken.T_NUMBER;
                            this.currentTokenValue = loc4;
                            this.dotUsedInNumber = false;
                            this.numberIsHex = false;
                        }
                        else if (loc4 == "\"" || loc4 == "\'") 
                        {
                            this.currentTokenType = monstrofil.expression.UbToken.T_STRING;
                            this.stringOpening = loc4;
                            this.currentTokenValue = "";
                        }
                    }
                }
                ++loc3;
            }
            return loc1;
        }

        internal function init():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:String=null;
            this.currentTokenType = -1;
            this.currentTokenValue = "";
            if (!initalized) 
            {
                initalized = true;
                loc1 = flash.utils.describeType(monstrofil.expression.UbToken);
                loc2 = loc1.constant;
                var loc6:*=0;
                var loc7:*=loc2;
                for each (loc3 in loc7) 
                {
                    loc4 = loc3.attribute("type");
                    loc5 = loc3.attribute("name");
                    if (!(loc4 == "String" && loc5.indexOf("S_") == 0)) 
                    {
                        continue;
                    }
                    symbols[monstrofil.expression.UbToken[loc5]] = true;
                }
            }
            return;
        }

        
        {
            initalized = false;
            symbols = new flash.utils.Dictionary();
        }

        internal var currentTokenType:int=-1;

        internal var currentTokenValue:String="";

        internal var stringOpening:String="";

        internal var stringEscape:Boolean=false;

        internal var dotUsedInNumber:Boolean=false;

        internal var numberIsHex:Boolean=false;

        internal var paragraphUsed:Boolean=false;

        internal static var initalized:Boolean=false;

        internal static var symbols:flash.utils.Dictionary;
    }
}
