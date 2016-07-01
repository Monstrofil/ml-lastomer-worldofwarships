package ML_Models 
{    
    import com.junkbyte.console.Cc;
    import flash.utils.Dictionary;
    import lesta.data.GameDelegate;
    import lesta.structs.Player;
    import lesta.utils.GameInfoHolder;
    import lesta.utils.Invoker;
    /**
     * ...
     * @author Monstrofil
     */
    public class ML_WebInfoHolder 
    {
        private static var _instance:ML_WebInfoHolder = new ML_WebInfoHolder();

        public function ML_WebInfoHolder()
        {
            if (_instance != null)
            {
                throw new Error("Singleton can only be accessed through Singleton.instance");
            }
            
            this.dummyDataObject.realData = false;
            GameInfoHolder.instance.addCallback(this, GameInfoHolder.LIST_PLAYERS, function(...rest) {
                for each(var player:Player in GameInfoHolder.instance.listPlayers) {
                    GameDelegate.addCallBack("updateWebData[" + player.name + "]", this, this.updateWebInfo);
                }
            });
        }
        
        public function getStatisticsObjectIfExists(playerName:String) {
            Cc.log(playerName);
            Cc.log(this.pythonData);
            return this.pythonData[playerName] || this.dummyDataObject;
        }
        
        private function updateWebInfo(arg1:Object) {
            Cc.log("updateWebInfo[" + arg1.name + "]");
            arg1['real_data'] = true;
            if (this.pythonData[arg1.name] == null) {
                this.pythonData[arg1.name] = arg1;
            }
            else {
                for(var id:String in arg1) {
                    this.pythonData[arg1.name][id] = arg1[id];
                }
            }
            this.evChanged.invoke([arg1.name]);
        }

        public static function get instance():ML_WebInfoHolder
        {
            return _instance;
        }
        
        private var pythonData:Dictionary = new Dictionary();
        private var dummyDataObject:Object = new Object();
        
        public var evChanged:Invoker = new Invoker();
        
    }

}