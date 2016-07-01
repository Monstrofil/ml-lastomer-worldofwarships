package 
{
    import lesta.datahub.DataHub;
    import lesta.dialogs.battle_window_new.HudElementController;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class XVMDatahubController extends HudElementController 
    {
        public static var xvmDataHub:DataHub;
        public function XVMDatahubController() 
        {
            super();
        }
                
        protected override function init():void{ 
            xvmDataHub = dataHub;
        }
    }

}