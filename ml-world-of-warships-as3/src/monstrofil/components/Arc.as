package monstrofil.components {
    import flash.display.Sprite;
    import lesta.utils.Geometry;
    import flash.display.LineScaleMode;
    import monstrofil.utils.DrawingShapes;
    
    public class Arc extends Sprite {
        private var radius:Number;
        private var lineWidth:Number;
        public function Arc(x:Number, y:Number, radius:Number, lineWidth:Number) {
            this.x = x;
            this.y = y;
            this.radius = radius;
            this.lineWidth = lineWidth;            
        }
        
        public function draw(angle_to, color=0xccFFcc) {
            this.graphics.clear();
            this.graphics.lineStyle(this.lineWidth, color, 1, false, LineScaleMode.NONE);
            DrawingShapes.drawArc(this.graphics, this.x, this.y, this.radius, angle_to, -90);
        }

    }
    
}
