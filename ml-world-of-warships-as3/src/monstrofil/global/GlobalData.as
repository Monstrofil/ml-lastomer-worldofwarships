package monstrofil.global
{
    import flash.filters.DropShadowFilter;
    import flash.text.TextFormat;
    import flash.geom.ColorTransform;
    import flash.text.Font;
    import flash.filters.GlowFilter;

    public class GlobalData
    {
        public function GlobalData()
        {
            if (_instance != null)
            {
                throw new Error("GlobalData can only be accessed through GlobalData.instance");
            }
        }

        public static function get instance():GlobalData
        {
            return _instance;
        }
        
        public function get shadowDefault():DropShadowFilter {
            var _shadowDefault = new  DropShadowFilter();
            _shadowDefault.alpha = 0.8;
            _shadowDefault.color = 0x101010;
            _shadowDefault.distance = 0;
        
            return _shadowDefault;
        }
        
        public function get shadowDefaultEars():DropShadowFilter{
            var _shadowDefault = new  DropShadowFilter();
            _shadowDefault.alpha = 0.6;
            _shadowDefault.color = 0x101010;
            _shadowDefault.distance = 0;
            _shadowDefault.blurX = 2;
            _shadowDefault.blurY = 2;
            
            return _shadowDefault;
        }
        
        public function get glowDefault():GlowFilter{
            var _glowFilterDefault = new GlowFilter();
            _glowFilterDefault.color = 0x101010;
            _glowFilterDefault.blurX = 3;
            _glowFilterDefault.blurY = 3;
            _glowFilterDefault.alpha = 0.6;
            
            return _glowFilterDefault;
        }
        
        public function get textColorDefault():uint {
            return this._textColorDefault;
        }
        
        public function get textFormatDefault():TextFormat {
            var _textFormatDefault = new TextFormat("$WWSDefaultFont");
            _textFormatDefault.size = 10;
            _textFormatDefault.color = this._textColorDefault;
            
            return _textFormatDefault;
        }
        
        public function get inactiveColorTransformDefault():ColorTransform {
            var _inactiveColorTransform = new ColorTransform();
            _inactiveColorTransform.color = this._inactiveColorDefault;
            return _inactiveColorTransform;
        }
        
        public function get activeColorTransformDefault():ColorTransform {
            var activeColorTransform = new ColorTransform();
            return activeColorTransform;
        }
        
        internal var _textColorDefault:uint = 0xF8F8F8;
        internal var _inactiveColorDefault:uint = 0xF8F8F8;
        
        private static var _instance:GlobalData = new GlobalData();
    }
}