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
            this.dummyDataObject.real_data = false;
            GameInfoHolder.instance.addCallback(this, "listPlayers", function(...rest):void {
                for each(var player:Player in GameInfoHolder.instance.listPlayers) {
                    GameDelegate.addCallBack("updateWebDataMarker[" + player.name + "]", this, this.updateWebInfo);
                }
            });
        }
        
        public function getStatisticsObjectIfExists(playerName:String):Object {
            return this.pythonData[playerName] || this.dummyDataObject;
        }
        
        public function getStatisticsComponent(playerName:String):Statistics {
            if (!this.components[playerName]) {
               var statisticsComponent:Statistics = new Statistics();
               this.components[playerName] = statisticsComponent; 
            }
            return this.components[playerName];
        }
        
        
        private function updateWebInfo(arg1:Object):void {
            Cc.log("updateWebDataMarker[" + arg1.name + "]", arg1);
            if (this.pythonData[arg1.name] == null) {
                this.pythonData[arg1.name] = arg1;
            }
            else {
                for(var id:String in arg1) {
                    this.pythonData[arg1.name][id] = arg1[id];
                }
            }
            
            if (!this.components[arg1.name]) {
               this.components[arg1.name] = new Statistics(); 
            }
            for (var id:String in arg1) {
               var statisticsComponent:Statistics = this.components[arg1.name];
               statisticsComponent.statistics[id] = arg1[id];
               statisticsComponent.evChanged.invoke([statisticsComponent]);
            }
            this.evChanged.invoke([arg1.name]);
        }

        public static function get instance():ML_WebInfoHolder
        {
            return _instance;
        }
        
        private var pythonData:Dictionary = new Dictionary();
        private var components:Dictionary = new Dictionary();
        private var dummyDataObject:Object = new Object();
        
        public var evChanged:Invoker = new Invoker();
        
    }

}