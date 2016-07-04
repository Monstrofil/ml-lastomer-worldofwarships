/**
 * ...
 * @author Monstrofil
 */
package monstrofil.global
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    public final class EarsConfig extends EventDispatcher
    {    
        public function EarsConfig()
        {
            if (_instance != null)
            {
                throw new Error("GlobalData can only be accessed through GlobalData.instance");
            }
            loadConfig();
        }
        
        public static function get instance():EarsConfig
        {
            return _instance;
        }
        
        private static var _instance:EarsConfig = new EarsConfig();
    
        private var xmlFileName:String = "battle_stats.xml";
        public var needReload:Boolean = false;
        public var xml:XML = new XML();
        
        public function loadConfig():void {
            var myTextLoader:URLLoader = new URLLoader();
            myTextLoader.addEventListener(Event.COMPLETE, this.onLoaded);
            myTextLoader.load(new URLRequest(this.xmlFileName));
        }
        
        public function onLoaded(e:Event):void {
            this.xml = XML(e.target.data);
            this.needReload = true;
            trace("[XVM] ears config loaded");
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
        
        
    }
}
