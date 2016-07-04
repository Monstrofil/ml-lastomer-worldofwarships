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
            trace("ML_WebInfoHolder");
            this.dummyDataObject.realData = false;
            GameInfoHolder.instance.addCallback(this, "listPlayers", function(...rest):void {
                trace("GameInfoHolder.instance.addCallback");
                for each(var player:Player in GameInfoHolder.instance.listPlayers) {
                    trace("updateWebData[" + player.name + "]");
                    GameDelegate.addCallBack("updateWebData[" + player.name + "]", this, this.updateWebInfo);
                }
            });
        }
        
        public function getStatisticsObjectIfExists(playerName:String):Object {
            return this.pythonData[playerName] || this.dummyDataObject;
        }
        
        private function updateWebInfo(arg1:Object):void {
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
            trace("this.evChanged.invoke([arg1.name]);");
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