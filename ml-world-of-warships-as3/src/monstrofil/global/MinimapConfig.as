package monstrofil.global
{
    import flash.filters.DropShadowFilter;
    import flash.text.TextFormat;
    import flash.geom.ColorTransform;
    import flash.text.Font;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.EventDispatcher;

    public class MinimapConfig extends EventDispatcher
    {
        public function MinimapConfig()
        {
            if (_instance != null)
            {
                throw new Error("GlobalData can only be accessed through GlobalData.instance");
            }
            this.loadConfig();
        }

        public static function get instance():MinimapConfig
        {
            return _instance;
        }
        
        public function loadConfig():void{
            var configLoader:URLLoader = new URLLoader();
            configLoader.addEventListener(Event.COMPLETE, onLoaded);
            configLoader.load(new URLRequest(this.configFile));
        }
        
        internal function onLoaded(e:Event):void {
            this.xml = new XML(e.target.data);
            this.configLoaded = true;
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
        
        private var configFile:String = "minimap.xml";
        public var xml:XML = null;
        public var configLoaded:Boolean = false;
        
        private static var _instance:MinimapConfig = new MinimapConfig();
    }
}