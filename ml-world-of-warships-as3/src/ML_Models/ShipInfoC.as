package ML_Models 
{
    import lesta.datahub.Component;
    import lesta.utils.Invoker;
	/**
     * ...
     * @author Monstrofil
     */
    public class ShipInfoC extends Component
    {
        public static var id:uint = 0;
        
        public function ShipInfoC() 
        {
            super();
            id += 1;
            this.evChanged.parent = this;
        }
        
        override public function get classID():uint
        {
            return 101;
        }
        
        override public function get className():String
        {
            return "shipInfo";
        }
        
        override public function get primaryKey():*
        {
            return id;
        }
        
        public function setShipInfo(arg1:Object) {
            this.shipInfo = arg1;
            this.evChanged.invoke([this]);
        }
        
        public var shipInfo:Object;
        public var evChanged:Invoker = new Invoker();
        
    }

}