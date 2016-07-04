package monstrofil.components {
    import flash.text.TextField;
    import monstrofil.global.GlobalData;
    import lesta.datahub.Entity;
    import monstrofil.expression.UbExpressionCompiler;

    public class UpdateAbleTextField extends flash.text.TextField implements IUpdateAbleObject {
        private var info:Object = null;
        private var entity:Entity = null;
        private var compiler:UbExpressionCompiler = new UbExpressionCompiler();
        
        public function UpdateAbleTextField() {
            super();
        }
        
        public function create(entity:Entity, info:Object):void {
            this.entity = entity;
            this.info = info;
            
            this.setTextFormat(GlobalData.instance.textFormatDefault);
            this.filters = [GlobalData.instance.shadowDefault];
            this.x = info.@x;
            this.y = info.@y;
            this.width = info.@width;
            this.height = info.@height;
            this.name = info.name;
            this.textColor = 0xFFFFFF;
        }
        
        public function update(entity:Entity):void {
            this.entity = entity;
            entity["setPrecision"] = this.setPrecision;
            
            this.visible = this.compiler.compile(this.info.visible, this.info.visible).eval(this.entity);
            if(this.visible){
                this.htmlText = this.compiler.compile(this.info.text, this.info.text).eval(this.entity);
            }
        }
        
        private var setPrecision:Function = function(number:Number, precision:int):Number {
             precision = Math.pow(10, precision);
             return Math.round(number * precision)/precision;
        }

    }
    
}
