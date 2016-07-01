package monstrofil.components {
    import lesta.controls.Image;
    import lesta.datahub.Entity;
    import monstrofil.expression.UbExpressionCompiler;
    
    public class UpdateAbleImage extends Image implements IUpdateAbleObject {
        private var info:Object = null;
        private var entity:Entity = null;
        private var compiler:UbExpressionCompiler = new UbExpressionCompiler();
        
        public function UpdateAbleImage() {
            super();
        }
        
        public function create(entity:Entity, info:Object):void {
            this.entity = entity;
            this.info = info;
            
            this.init();
            this.x = info.@x;
            this.y = info.@y;
            this.scaleX = info.@scaleX;
            this.scaleY = info.@scaleY;
            this.name = info.@name;
        }
        
        public function update(entity:Entity):void {
            this.entity = entity;
            
            this.visible = this.compiler.compile(info.@visible,info.@visible).eval(this.entity);
            if(this.visible){
                this.src = this.compiler.compile(info.@src,info.@src).eval(this.entity);
            
                this.scaleX = info.@scaleX;
                this.scaleY = info.@scaleY;
            }
        }

    }
    
}
