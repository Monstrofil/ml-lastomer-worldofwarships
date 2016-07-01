package monstrofil.global  {
    
    public final class Singleton
    {
        private static var _instance:Singleton = new Singleton();

        public function Singleton()
        {
            if (_instance != null)
            {
                throw new Error("Singleton can only be accessed through Singleton.instance");
            }
        }

        public static function get instance():Singleton
        {
            return _instance;
        }
    }
    
}
