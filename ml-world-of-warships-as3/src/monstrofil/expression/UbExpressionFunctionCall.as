package monstrofil.expression 
{
    import __AS3__.vec.*;
    
    public class UbExpressionFunctionCall extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UbExpressionFunctionCall(arg1:monstrofil.expression.UbASTNodeFunctionCall)
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            this.compiledArgs = new Vector.<monstrofil.expression.IUbExpression>();
            super(arg1);
            var loc1:*=arg1.args;
            if (loc1) 
            {
                loc2 = 0;
                loc3 = loc1.length;
                while (loc2 < loc3) 
                {
                    loc4 = monstrofil.expression.UbExpressionCompiler.createExpression(loc1[loc2]);
                    this.compiledArgs.push(loc4);
                    addRequestedPropertiesOfExpression(loc4);
                    ++loc2;
                }
            }
            this.fromProc = monstrofil.expression.UbExpressionCompiler.createExpression(arg1.source);
            addRequestedPropertiesOfExpression(this.fromProc);
            return;
        }

        public override function eval(arg1:Object):*
        {
            var loc1:*=this.fromProc.eval(arg1);
            var loc2:*=[];
            var loc3:*=0;
            var loc4:*=this.compiledArgs.length;
            while (loc3 < loc4) 
            {
                loc2[loc3] = this.compiledArgs[loc3].eval(arg1);
                ++loc3;
            }
            return loc1.apply(null, loc2);
        }

        internal var compiledArgs:__AS3__.vec.Vector.<monstrofil.expression.IUbExpression>;

        internal var fromProc:monstrofil.expression.IUbExpression;
    }
}
