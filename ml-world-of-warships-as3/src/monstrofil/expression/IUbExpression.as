package monstrofil.expression 
{
    import flash.utils.*;
    
    public interface IUbExpression
    {
        function eval(arg1:Object):*;

        function get requestedProps():flash.utils.Dictionary;

        function get astType():int;

        function get isConstant():Boolean;
    }
}
