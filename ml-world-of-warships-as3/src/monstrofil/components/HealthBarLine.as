package monstrofil.components {
    
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.geom.*;
    import flash.filters.DropShadowFilter; 
    
    public class HealthBarLine extends Sprite {
        public var right:Boolean = false;
        public var alpha_:Number = 1;
        
        internal var last_hp:int = 0;
        public function HealthBarLine() {
            super();
        }
        
        public function RGBToHex(r:int, g:int, b:int):uint
        {
            var hex:uint = r << 16 | g << 8 | b;
            return hex;
        }

        public function draw(currentHp: int, maxHp: int, maxWidth: int, maxHeight: int)
        {
            if(maxHp == 0)
                maxHp = currentHp + 1;
                
            if(currentHp != this.last_hp)
                this.last_hp = currentHp;
            else
                return;
                
            var g:Graphics = this.graphics;
            g.clear();

            var pers = currentHp * 100 / maxHp;
            var color:uint = RGBToHex(0,0,0);
            if (pers > 0)
            {
                //15 - 0
                color = RGBToHex(128,0,0);
            }
            if (pers > 15)
            {
                //25 - 15
                color = RGBToHex(204,102,0);
            }
            if (pers > 25)
            {
                //50 - 25
                color = RGBToHex(255,153,0);
            }
            if (pers > 50)
            {
                //75 - 50
                color = RGBToHex(153,204,0);
            }
            if (pers > 75)
            {
                //100 - 75
                color = RGBToHex(0,153,0);
            }


            g.beginFill( color, alpha_ );
            if (right)
            {
                g.drawRect( maxWidth - currentHp * maxWidth / maxHp, 0, currentHp * maxWidth / maxHp, maxHeight);
            }
            else
            {
                g.drawRect( 0, 0, currentHp * maxWidth / maxHp, maxHeight);
            }
            g.endFill( );
        }
    }
    
}

