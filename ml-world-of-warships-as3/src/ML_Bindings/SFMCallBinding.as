package ML_Bindings 
{
    import com.junkbyte.console.Cc;
    import lesta.data.GameDelegate;
	import lesta.libs.unbound.SFMEventBinding;
	
	/**
     * ...
     * @author Monstrofil
     */
    public class SFMCallBinding extends SFMEventBinding 
    {
        
        public function SFMCallBinding() 
        {
            super();
			
        }
        
        override protected function sendSFMEvent(param1:String, param2:Object) : void
        {
            Cc.log(param1, [param2]);
            GameDelegate.call(param1, [param2]);
        }
        
    }

}