package
{
    import com.junkbyte.console.Cc;
    import lesta.dialogs.battle_window.markers.container.views.ships.*;
    import lesta.datahub.Entity;
    import flash.external.ExternalInterface;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import lesta.components.Avatar;
    import flashx.textLayout.formats.TextAlign;
    import flash.text.TextFormatAlign;
    import lesta.components.Timer;
    import lesta.unbound.bindings.UbBinding;
    import lesta.unbound.core.UbGlobalDefinitions;
    import lesta.unbound.core.UbRootScope;
    import lesta.unbound.core.UbScope;
    import lesta.unbound.layout.UbBlock;
    import lesta.unbound.layout.UbRootBlock;
    import ML_Controllers.ML_MarkerInfoController;
    import ML_Unbound.ML_UnboundApplication;
    
    public dynamic class ShipIconButtonClip extends lesta.dialogs.battle_window.markers.container.views.ships.ShipMarker
    {
        private var ubMarker:UbBlock = null;
        
        public function ShipIconButtonClip()
        {
            super();
            addFrameScript(0, this.frame1, 9, this.frame10, 19, this.frame20, 29, this.frame30, 39, this.frame40, 40, this.frame41, 49, this.frame50, 59, this.frame60, 69, this.frame70, 79, this.frame80);
            
            return;
        }
        
        public override function show(arg1:lesta.datahub.Entity):void
        {
            super.show(arg1);
            if (this.ubMarker)
                return;
            
            if (ML_UnboundApplication.instance)
            {
                this.buildMagicBlock();
            }
            else
            {
                ML_UnboundApplication.evComplete.addCallback(this.onUbComplete);
            }
        }
        
        private function buildMagicBlock()
        {
            ML_Controllers.ML_MarkerInfoController.lastAvatarEntityIdAdded = this.entity.id; //TODO: find better solution
            ML_Controllers.ML_MarkerInfoController.lastAvatarPythonIdAdded = this.entity.avatar.id;
            
            this.ubMarker = ML_UnboundApplication.instance.makeRootBlock("MagicMarkerBlock");
            this.icon.addChild(this.ubMarker);
        }
        
        private function onUbComplete()
        {
            ML_UnboundApplication.evComplete.removeCallback(this.onUbComplete);
            this.buildMagicBlock();
        }
        
        internal function frame1():*
        {
            return;
        }
        
        internal function frame10():*
        {
            stop();
            return;
        }
        
        internal function frame20():*
        {
            stop();
            return;
        }
        
        internal function frame30():*
        {
            stop();
            return;
        }
        
        internal function frame40():*
        {
            stop();
            return;
        }
        
        internal function frame41():*
        {
            return;
        }
        
        internal function frame50():*
        {
            stop();
            return;
        }
        
        internal function frame60():*
        {
            stop();
            return;
        }
        
        internal function frame70():*
        {
            stop();
            return;
        }
        
        internal function frame80():*
        {
            stop();
            return;
        }
    }
}
