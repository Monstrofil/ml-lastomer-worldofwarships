package monstrofil.expression 
{
    import __AS3__.vec.*;
    import lesta.unbound.expression.IUbExpression;
    
    public class UbExpressionHash extends monstrofil.expression.UbExpressionBase implements lesta.unbound.expression.IUbExpression, monstrofil.expression.IUbExpression
    {
        public function UbExpressionHash(arg1:monstrofil.expression.UbASTNodeHash)
        {
            var loc4:*=null;
            var loc5:*=null;
            this.keys = new Vector.<String>();
            this.values = new Vector.<monstrofil.expression.IUbExpression>();
            super(arg1);
            var loc1:*=arg1.items;
            var loc2:*=0;
            var loc3:*=loc1.length;
            while (loc2 < loc3) 
            {
                loc4 = loc1[loc2];
                this.keys.push(loc4.key);
                loc5 = monstrofil.expression.UbExpressionCompiler.createExpression(loc4.value);
                this.values.push(loc5);
                addRequestedPropertiesOfExpression(loc5);
                ++loc2;
            }
            return;
        }

        public override function eval(arg1:Object):*
        {
            var loc1:*={};
            var loc2:*=0;
            var loc3:*=this.keys.length;
            while (loc2 < loc3) 
            {
                loc1[this.keys[loc2]] = this.values[loc2].eval(arg1);
                ++loc2;
            }
            return loc1;
        }

        internal var keys:__AS3__.vec.Vector.<String>;

        internal var values:__AS3__.vec.Vector.<monstrofil.expression.IUbExpression>;
    }
}
