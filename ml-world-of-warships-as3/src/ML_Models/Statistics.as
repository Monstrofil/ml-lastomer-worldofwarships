package ML_Models
{
    import lesta.datahub.Component;
    import lesta.utils.Invoker;
    
    /**
     * ...
     * @author Monstrofil
     */
    public class Statistics extends Component
    {
        public static var id:uint = 0;
        
        public function Statistics()
        {
            super();
            id += 1;
            this.evChanged.parent = this;
            this.statistics.real_data = false;
        }
        
        override public function get classID():uint
        {
            return 100;
        }
        
        override public function get className():String
        {
            return "statistics";
        }
        
        override public function get primaryKey():*
        {
            return id;
        }
        
        public var evChanged:Invoker = new Invoker();
        public var statistics:Object = new Object();
    }

}