package monstrofil.expression
{
   public class UbParser extends Object
   {
       
      private var tokenCount:int;
      
      private var tokens:Vector.<UbToken>;
      
      private var pointer:int;
      
      private var debugText:String;
      
      public function UbParser()
      {
         super();
      }
      
      public function createAST(param1:Vector.<UbToken>, param2:String) : IUbASTNode
      {
         this.debugText = param2;
         this.tokens = param1;
         this.tokenCount = param1.length;
         this.pointer = 0;
         var _loc3_:IUbASTNode = this.ternaryExpression();
         this.tokens = null;
         if(this.pointer < this.tokenCount)
         {
            throw new Error("Binding expression\'s compilation error: " + param1);
         }
         return _loc3_;
      }
      
      private function ternaryExpression() : IUbASTNode
      {
         var _loc2_:IUbASTNode = null;
         var _loc3_:IUbASTNode = null;
         var _loc1_:IUbASTNode = this.logicalExpression();
         if(_loc1_ == null)
         {
            this.error("condition missing");
         }
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_TERNARY_COND))
         {
            _loc2_ = this.ternaryExpression();
            if(_loc2_ == null)
            {
               this.error("missing expression after ? operator");
            }
            if(!this.testNextToken(UbToken.T_SYMBOL,UbToken.S_TERNARY_ALT))
            {
               this.error("missing : after first alternative");
            }
            _loc3_ = this.ternaryExpression();
            if(_loc3_ == null)
            {
               this.error("missing false alternative");
            }
            return new UbASTNodeCondition(_loc1_,_loc2_,_loc3_);
         }
         return _loc1_;
      }
      
      private function logicalExpression() : IUbASTNode
      {
         var _loc6_:UbToken = null;
         var _loc7_:IUbASTNode = null;
         var _loc1_:Array = [this.comparisonExpression()];
         var _loc2_:Array = [];
         while(true)
         {
            _loc6_ = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_AND,UbToken.S_OR);
            if(_loc6_)
            {
               _loc7_ = this.comparisonExpression();
               if(!_loc7_)
               {
                  this.error("missing second operand for logical expression");
               }
               _loc1_.push(_loc7_);
               _loc2_.push(_loc6_.value);
               continue;
            }
            break;
         }
         var _loc3_:IUbASTNode = _loc1_[0];
         var _loc4_:int = 1;
         var _loc5_:int = _loc1_.length;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = new UbASTNodeBinaryOp(_loc3_,_loc2_[_loc4_ - 1],_loc1_[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function comparisonExpression() : IUbASTNode
      {
         var _loc3_:IUbASTNode = null;
         var _loc1_:IUbASTNode = this.bitwiseExpression();
         var _loc2_:UbToken = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_EQ,UbToken.S_NEQ,UbToken.S_MORE,UbToken.S_LESS,UbToken.S_EQ_MORE,UbToken.S_EQ_LESS);
         if(_loc2_ == null)
         {
            _loc2_ = this.testNextToken(UbToken.T_IDENTIFIER,UbToken.I_IN);
         }
         if(_loc2_)
         {
            _loc3_ = this.bitwiseExpression();
            if(!_loc3_)
            {
               this.error("missing second operand for comparison expression");
            }
            return new UbASTNodeBinaryOp(_loc1_,_loc2_.value,_loc3_);
         }
         return _loc1_;
      }
      
      private function bitwiseExpression() : IUbASTNode
      {
         var _loc2_:UbToken = null;
         var _loc3_:IUbASTNode = null;
         var _loc1_:IUbASTNode = this.arithmeticExpressionAdd();
         while(true)
         {
            _loc2_ = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_BITWISE_AND,UbToken.S_BITWISE_OR,UbToken.S_BITWISE_XOR,UbToken.S_BITWISE_L_SHIFT,UbToken.S_BITWISE_R_SHIFT);
            if(_loc2_)
            {
               _loc3_ = this.arithmeticExpressionAdd();
               if(!_loc3_)
               {
                  this.error("missing second operand for bitwise expression");
               }
               _loc1_ = new UbASTNodeBinaryOp(_loc1_,_loc2_.value,_loc3_);
               continue;
            }
            break;
         }
         return _loc1_;
      }
      
      private function arithmeticExpressionAdd() : IUbASTNode
      {
         var _loc2_:UbToken = null;
         var _loc3_:IUbASTNode = null;
         var _loc1_:IUbASTNode = this.arithmeticExpressionMul();
         while(true)
         {
            _loc2_ = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_ADD,UbToken.S_NEG);
            if(_loc2_)
            {
               _loc3_ = this.arithmeticExpressionMul();
               if(!_loc3_)
               {
                  this.error("missing second operand for arithmetic expression");
               }
               _loc1_ = new UbASTNodeBinaryOp(_loc1_,_loc2_.value,_loc3_);
               continue;
            }
            break;
         }
         return _loc1_;
      }
      
      private function arithmeticExpressionMul() : IUbASTNode
      {
         var _loc2_:UbToken = null;
         var _loc3_:IUbASTNode = null;
         var _loc1_:IUbASTNode = this.chainExpression();
         while(true)
         {
            _loc2_ = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_MUL,UbToken.S_DIV,UbToken.S_MOD);
            if(_loc2_)
            {
               _loc3_ = this.chainExpression();
               if(!_loc3_)
               {
                  this.error("missing second operand for arithmetic expression");
               }
               _loc1_ = new UbASTNodeBinaryOp(_loc1_,_loc2_.value,_loc3_);
               continue;
            }
            break;
         }
         return _loc1_;
      }
      
      private function chainExpression() : IUbASTNode
      {
         var _loc2_:UbToken = null;
         var _loc3_:IUbASTNode = null;
         var _loc4_:Vector.<IUbASTNode> = null;
         var _loc1_:IUbASTNode = this.logicalNotExpression();
         while(true)
         {
            if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_DOT))
            {
               _loc2_ = this.testNextToken(UbToken.T_IDENTIFIER);
               if(!_loc2_)
               {
                  this.error("missing identifier after dot");
               }
               _loc1_ = new UbASTNodeGetPropertyString(_loc1_,_loc2_.value);
               continue;
            }
            if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_LEFT_BRACKET))
            {
               _loc3_ = this.ternaryExpression();
               if(_loc3_ == null)
               {
                  this.error("missing expression in brackets");
               }
               if(!this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACKET))
               {
                  this.error("missing closing right bracket");
               }
               _loc1_ = new UbASTNodeGetProperty(_loc1_,_loc3_);
               continue;
            }
            if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_LEFT_BRACE))
            {
               if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACE))
               {
                  _loc1_ = new UbASTNodeFunctionCall(_loc1_);
               }
               else
               {
                  _loc4_ = new Vector.<IUbASTNode>();
                  _loc4_.push(this.ternaryExpression());
                  while(true)
                  {
                     if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_COMMA))
                     {
                        _loc4_.push(this.ternaryExpression());
                     }
                     else
                     {
                        if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACE))
                        {
                           break;
                        }
                        this.error("unexpected token in function call");
                     }
                  }
                  _loc1_ = new UbASTNodeFunctionCall(_loc1_,_loc4_);
               }
               continue;
            }
            break;
         }
         return _loc1_;
      }
      
      private function logicalNotExpression() : IUbASTNode
      {
         var _loc1_:UbToken = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_NOT);
         if(_loc1_)
         {
            return new UbASTNodeUnaryOp(_loc1_.value,this.logicalNotExpression());
         }
         return this.negateExpression();
      }
      
      private function negateExpression() : IUbASTNode
      {
         var _loc1_:UbToken = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_NEG);
         if(_loc1_)
         {
            return new UbASTNodeUnaryOp(_loc1_.value,this.negateExpression());
         }
         return this.bitwiseNotExpression();
      }
      
      private function bitwiseNotExpression() : IUbASTNode
      {
         var _loc1_:UbToken = this.testNextToken(UbToken.T_SYMBOL,UbToken.S_BITWISE_NOT);
         if(_loc1_)
         {
            return new UbASTNodeUnaryOp(_loc1_.value,this.bitwiseNotExpression());
         }
         return this.basicExpression();
      }
      
      private function basicExpression() : IUbASTNode
      {
         var _loc1_:IUbASTNode = null;
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_LEFT_BRACE))
         {
            _loc1_ = this.ternaryExpression();
            if(!this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACE))
            {
               this.error("missing closing brace");
            }
            return _loc1_;
         }
         return this.atomExpression();
      }
      
      private function atomExpression() : IUbASTNode
      {
         var _loc1_:UbToken = null;
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_LEFT_CURLY))
         {
            return this.hashExpression();
         }
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_LEFT_BRACKET))
         {
            return this.listExpression();
         }
         _loc1_ = this.testNextToken(UbToken.T_NUMBER | UbToken.T_IDENTIFIER | UbToken.T_STRING);
         if(_loc1_ == null)
         {
            this.error("missing identifier or number or string");
         }
         return new UbASTNodeTerminal(_loc1_.type,_loc1_.value);
      }
      
      private function listExpression() : UbASTNodeList
      {
         var _loc1_:Array = null;
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACKET))
         {
            return new UbASTNodeList([]);
         }
         _loc1_ = [this.ternaryExpression()];
         while(true)
         {
            if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_COMMA))
            {
               _loc1_.push(this.ternaryExpression());
            }
            else
            {
               if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_BRACKET))
               {
                  break;
               }
               this.error("unexpected token in list definition");
            }
         }
         return new UbASTNodeList(_loc1_);
      }
      
      private function hashExpression() : UbASTNodeHash
      {
         var _loc1_:Vector.<UbASTHashPair> = null;
         if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_CURLY))
         {
            return new UbASTNodeHash(new Vector.<UbASTHashPair>());
         }
         _loc1_ = new Vector.<UbASTHashPair>();
         _loc1_.push(this.hashPair());
         while(true)
         {
            if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_COMMA))
            {
               _loc1_.push(this.hashPair());
            }
            else
            {
               if(this.testNextToken(UbToken.T_SYMBOL,UbToken.S_RIGHT_CURLY))
               {
                  break;
               }
               this.error("unexpected token in hash definition");
            }
         }
         return new UbASTNodeHash(_loc1_);
      }
      
      private function hashPair() : UbASTHashPair
      {
         var _loc1_:UbToken = this.testNextToken(UbToken.T_IDENTIFIER | UbToken.T_STRING);
         if(!_loc1_)
         {
            this.error("expected identifier in hash definition");
         }
         var _loc2_:String = _loc1_.value;
         if(!this.testNextToken(UbToken.T_SYMBOL,UbToken.S_TERNARY_ALT))
         {
            this.error("expected colon after hash key");
         }
         var _loc3_:IUbASTNode = this.ternaryExpression();
         return new UbASTHashPair(_loc2_,_loc3_);
      }
      
      private function testNextToken(param1:int, ... rest) : UbToken
      {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc3_:UbToken = this.nextToken();
         if(_loc3_ != null)
         {
            if(_loc3_.type & param1)
            {
               _loc4_ = rest.length;
               if(_loc4_ == 0)
               {
                  return _loc3_;
               }
               _loc5_ = _loc3_.value;
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  if(rest[_loc6_] == _loc5_)
                  {
                     return _loc3_;
                  }
                  _loc6_++;
               }
            }
            this.returnToken();
            return null;
         }
         return null;
      }
      
      private function nextToken() : UbToken
      {
         if(this.pointer < this.tokenCount)
         {
            return this.tokens[this.pointer++];
         }
         return null;
      }
      
      private function returnToken() : void
      {
         this.pointer--;
      }
      
      private function error(param1:String) : *
      {
         throw new Error("UbParser -- error: " + param1 + "\n at: \n" + this.debugText);
      }
   }
}
