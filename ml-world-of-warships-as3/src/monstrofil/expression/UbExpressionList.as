package monstrofil.expression 
{
    import __AS3__.vec.*;
    
    public class UbExpressionList extends monstrofil.expression.UbExpressionBase implements monstrofil.expression.IUbExpression
    {
        public function UbExpressionList(arg1:monstrofil.expression.UbASTNodeList)
        {
            var loc4:*=null;
            this.compiledItems = new Vector.<monstrofil.expression.IUbExpression>();
            super(arg1);
            var loc1:*=arg1.items;
            var loc2:*=0;
            var loc3:*=loc1.length;
            while (loc2 < loc3) 
            {
                loc4 = monstrofil.expression.UbExpressionCompiler.createExpression(loc1[loc2]);
                this.compiledItems.push(loc4);
                addRequestedPropertiesOfExpression(loc4);
                ++loc2;
            }
            return;
        }

        public override function eval(arg1:Object):*
        {
            var loc1:*=[];
            var loc2:*=0;
            var loc3:*=this.compiledItems.length;
            while (loc2 < loc3) 
            {
                loc1.push(this.compiledItems[loc2].eval(arg1));
                ++loc2;
            }
            return loc1;
        }

        internal var compiledItems:__AS3__.vec.Vector.<monstrofil.expression.IUbExpression>;
    }
}
