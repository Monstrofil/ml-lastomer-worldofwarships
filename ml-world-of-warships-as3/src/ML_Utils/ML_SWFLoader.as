package ML_Utils 
{
    import flash.display.*;
    import flash.events.Event;
    import flash.net.*;
    import flash.system.*;
    import lesta.utils.*;
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_SWFLoader 
    {
        public function ML_SWFLoader() 
        {
            
        }
        
        public function load(filename:String, callback:Function = null) :void {
            var tempLoader:Loader = new Loader();
            if (callback != null) {
                tempLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                    callback(e);
                });
            }
            tempLoader.load(new URLRequest(filename), new LoaderContext(false, ApplicationDomain.currentDomain)); 
        }
        
    }

}