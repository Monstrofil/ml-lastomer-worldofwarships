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

    public class GuiSlotsConfig extends EventDispatcher
    {
        public function GuiSlotsConfig()
        {
            if (_instance != null)
            {
                throw new Error("GlobalData can only be accessed through GlobalData.instance");
            }
            loadConfig();
        }

        public static function get instance():GuiSlotsConfig
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
            this.ConfigLoaded = true;
            this.dispatchEvent(new Event(Event.COMPLETE));
            trace("[XVM]: gui_slots config loaded.")
        }
        
        public var configFile:String = "gui_slots.xml";
        public var xml:XML = null;
        public var inProgress:Boolean = false;
        public var ConfigLoaded:Boolean = false;
        private static var _instance:GuiSlotsConfig = new GuiSlotsConfig();
    }
}