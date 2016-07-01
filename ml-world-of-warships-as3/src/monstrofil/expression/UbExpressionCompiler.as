package monstrofil.expression 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import lesta.unbound.expression.IUbExpression;
    
    public class UbExpressionCompiler extends Object
    {
        public function UbExpressionCompiler()
        {
            super();
            if (expressionClassesByASTType.length == 0) 
            {
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionBinaryOperation);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionCondition);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionFunctionCall);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionGetProperty);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionGetPropertyString);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionHash);
                expressionClassesByASTType.push(monstrofil.expression.UbExpressionList);
                expressionClassesByASTType.push(monstrofil.expression.UBExpressionTerminal);
                expressionClassesByASTType.push(monstrofil.expression.UBExpressionUnaryOperation);
            }
            this.lexer = new monstrofil.expression.UbLexer();
            this.parser = new monstrofil.expression.UbParser();
            var loc1:*;
            instanceCounter++;
            return;
        }

        public function fini():void
        {
            if (this.lexer) 
            {
                this.lexer;
                var loc1:*;
                var loc2:*;
            }
            if (this.lexer) 
            {
                expressionCache = new flash.utils.Dictionary();
            }
            this.lexer = null;
            this.parser = null;
            return;
        }

        public function compile(arg1:String, arg2:String="[No debug text]"):lesta.unbound.expression.IUbExpression
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=null;
            var loc2:*=arg1 + ":" + arg2;
            if (loc2 in expressionCache) 
            {
                loc1 = expressionCache[loc2];
            }
            else 
            {
                loc3 = this.lexer.tokenize(arg1);
                loc4 = this.parser.createAST(loc3, arg2);
                loc1 = createExpression(loc4);
                expressionCache[loc2] = loc1;
            }
            return loc1;
        }

        public function compileLValueSetter(arg1:String):Function
        {
            var loc1:*=this.lexer.tokenize(arg1);
            var loc2:*=this.parser.createAST(loc1, arg1);
            return this.generateLValueSetter(loc2);
        }

        internal function generateLValueSetter(arg1:monstrofil.expression.IUbASTNode):Function
        {
            var ast:monstrofil.expression.IUbASTNode;
            var currentNode:monstrofil.expression.IUbASTNode;
            var chain:Array;
            var base:String;
            var chainLength:int;
            var propNode:monstrofil.expression.UbASTNodeGetProperty;
            var propStringNode:monstrofil.expression.UbASTNodeGetPropertyString;

            var loc1:*;
            chain = null;
            base = null;
            chainLength = 0;
            propNode = null;
            propStringNode = null;
            ast = arg1;
            currentNode = ast;
            chain = [];
            for (;;) 
            {
                if (currentNode is monstrofil.expression.UbASTNodeTerminal) 
                {
                    base = monstrofil.expression.UbASTNodeTerminal(currentNode).value;
                    break;
                }
                if (currentNode is monstrofil.expression.UbASTNodeGetProperty) 
                {
                    propNode = monstrofil.expression.UbASTNodeGetProperty(currentNode);
                    chain.push(createExpression(propNode.property));
                    currentNode = propNode.source;
                    continue;
                }
                if (currentNode is monstrofil.expression.UbASTNodeGetPropertyString) 
                {
                    propStringNode = monstrofil.expression.UbASTNodeGetPropertyString(currentNode);
                    chain.push(propStringNode.property);
                    currentNode = propStringNode.source;
                    continue;
                }
                throw new Error("Failed to compile LValueSetter -- invalid node type");
            }
            chainLength = chain.length;
            chain.reverse();
            return function (arg1:*, arg2:*):void
            {
                var loc2:*=undefined;
                var loc3:*=undefined;
                var loc4:*=undefined;
                var loc1:*=arg1;
                if (chainLength != 0) 
                {
                    loc4 = 0;
                    while (loc4 < (chainLength - 1)) 
                    {
                        loc2 = chain[loc4];
                        if (loc2 is String) 
                        {
                            loc1 = loc1[loc2];
                        }
                        else 
                        {
                            loc3 = loc2 as monstrofil.expression.IUbExpression;
                            loc1 = loc1[loc3.eval(arg1)];
                        }
                        ++loc4;
                    }
                    loc2 = chain[(chainLength - 1)];
                    if (loc2 is String) 
                    {
                        loc1[loc2] = arg2;
                    }
                    else 
                    {
                        loc3 = loc2 as monstrofil.expression.IUbExpression;
                        loc1[loc3.eval(arg1)] = arg2;
                    }
                }
                else 
                {
                    loc1[base] = arg2;
                }
                return;
            }
        }

        public static function createExpression(arg1:monstrofil.expression.IUbASTNode):monstrofil.expression.IUbExpression
        {
            return new expressionClassesByASTType[arg1.astType](arg1);
        }

        public static function createSimpleGetterExpression(arg1:String):monstrofil.expression.UbExpressionGetPropertyString
        {
            return new monstrofil.expression.UbExpressionGetPropertyString(new monstrofil.expression.UbASTNodeGetPropertyString(new monstrofil.expression.UbASTNodeTerminal(monstrofil.expression.UbToken.T_IDENTIFIER, "$this"), arg1));
        }

        
        {
            expressionCache = new flash.utils.Dictionary();
            instanceCounter = 0;
        }

        public static const expressionClassesByASTType:__AS3__.vec.Vector.<Class>=new Vector.<Class>();

        internal var lexer:monstrofil.expression.UbLexer;

        internal var parser:monstrofil.expression.UbParser;

        internal static var expressionCache:flash.utils.Dictionary;

        internal static var instanceCounter:int=0;
    }
}
