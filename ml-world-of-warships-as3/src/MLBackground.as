package
{
    import com.junkbyte.console.*;
    import com.monstrofil.XMLProcessor;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import lesta.constants.*;
    import lesta.cpp.*;
    import lesta.data.*;
    import lesta.datahub.*;
    import lesta.dialogs.dock.constants.*;
    import lesta.libs.unbound.*;
    import lesta.structs.*;
    import lesta.unbound.bindings.*;
    import lesta.unbound.core.*;
    import lesta.unbound.layout.*;
    import lesta.unbound.style.*;
    import lesta.utils.*;
    import lesta.utils.queue.*;
    import lesta.utils.resourceLoading.*;
    import ML_Models.ML_WebInfoHolder;
    import ML_Unbound.*;
    import ML_Utils.*;
    import monstrofil.unbound.*;
    import scaleform.clik.managers.*;
    import scaleform.gfx.*;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class MLBackground extends MovieClip
    {
        
        [Embed(source = "WoWsSymbol.ttf", fontName = "ML_WOWSSymbol", mimeType = "application/x-font", advancedAntiAliasing = "true", embedAsCFF = "false")]
        private var ml_wowsSymbol:Class;
        
        [Embed(source = "XVMSymbol.ttf", fontName = "ML_WOTSymbol", mimeType = "application/x-font", advancedAntiAliasing = "true", embedAsCFF = "false")]
        private var ml_wotSymbol:Class;
        public function MLBackground()
        {
            Font.registerFont(ml_wowsSymbol);
            Font.registerFont(ml_wotSymbol);
            
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.setupDataHolders();
        }
        
        private function setupDataHolders():void {
            var statsHolder:ML_Models.ML_WebInfoHolder = ML_Models.ML_WebInfoHolder.instance;
        }
        
        public function onAddedToStage(e:Event):void {    
            Cc.config.commandLineAllowed = true;
            Cc.start(this, "debug");
            Cc.y = 200;
            Cc.x = 200;
            
            var xvm:ML_UnboundApplication = new ML_UnboundApplication(this.stage, "RootBlock");
            this.parent.addChild(xvm);
        }
        
        
        public var _global:__Global;
    }

}