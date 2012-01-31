package core.locators 
{
	
	//public class Enforcer{}
	
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicWorldLocator 
	{
		
		private static var _instance:PhysicWorldLocator;
		private var _world:b2World;
		
		public static function get instance():PhysicWorldLocator
		{
			if (!_instance)
				_instance = new PhysicWorldLocator(/*new Enforcer*/);
				
			return _instance;
		}
		
		public function PhysicWorldLocator(/*protection:Enforcer*/) 
		{
			/*if (!protection)
				throw(new Error('singleton duplication'));пофиг*/
		}
		
		public function set world(value:b2World):void
		{
			_world = value;
		}
		
		public function get world():b2World
		{
			return _world
		}
		
	}
	
	

}