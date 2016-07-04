package monstrofil.components
{
    import monstrofil.components.Arc;
    
    public class HealthBarCircle extends Arc
    {
        
        internal var last_hp:int = 0;
        
        public function HealthBarCircle(x:Number, y:Number, radius:Number, w:Number)
        {
            super(x, y, radius, w);
        }
        
        public function draw_bar(health:Number, maxHealth:Number, color:uint = 0xccFFcc):void
        {
            if (health != this.last_hp){
                this.last_hp = health;
            }
            else {
                return;
            }
            
            if (health * maxHealth != 0)
            {
                var angle_from:Number = -90;
                var angle_to:Number = 360.0 * health / maxHealth;
                
                super.draw(angle_to, color);
            }
        
        }
    
    }

}
