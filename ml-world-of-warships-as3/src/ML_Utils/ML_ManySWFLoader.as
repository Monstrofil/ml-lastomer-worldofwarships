package ML_Utils 
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_ManySWFLoader extends EventDispatcher
    {
        private var _loaded:int = 0;
        private var _files:Array;
        public function ML_ManySWFLoader() 
        {
            
        }
        
        public function load(arg1:Array):void {
            this._files = arg1;
            this.loadNext();
        }
        
        private function loadNext():void {
            if (_loaded != _files.length) {
                var singleLoader:ML_SWFLoader = new ML_SWFLoader();
                singleLoader.load(_files[_loaded], this.loadNext);
                _loaded += 1;
            }
            else {
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
        
    }

}