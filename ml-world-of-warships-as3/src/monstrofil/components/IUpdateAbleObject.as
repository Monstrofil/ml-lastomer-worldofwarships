package monstrofil.components  {
    import lesta.datahub.Entity;
    
    public interface IUpdateAbleObject {
        function create(entity:Entity, info:Object):void;
        function update(entity:Entity):void;
    }
    
}
