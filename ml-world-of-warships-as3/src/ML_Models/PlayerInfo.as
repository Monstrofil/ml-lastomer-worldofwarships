package ML_Models 
{
    import lesta.datahub.Component;
    import lesta.structs.Player;
    import lesta.utils.Invoker;
	/**
     * ...
     * @author Monstrofil
     */
    public class PlayerInfo extends Component
    {
        public static var id:uint = 0;
        
        public function PlayerInfo() 
        {
            super();
            id += 1;
            this.evChanged.parent = this;
        }
        
        override public function get classID():uint
        {
            return 102;
        }
        
        override public function get className():String
        {
            return "player";
        }
        
        override public function get primaryKey():*
        {
            return id;
        }
        
        public function setPlayer(arg1:Player) {
            this.playerInfo = arg1;
            this.evChanged.invoke([this]);
        }
        
        public var playerInfo:Player;
        public var evChanged:Invoker = new Invoker();
        
    }

}