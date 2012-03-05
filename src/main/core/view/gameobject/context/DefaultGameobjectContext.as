package core.view.gameobject.context 
{
	import patterns.strategy.Strategy;
	/**
	 * ...
	 * @author 
	 */
	public class DefaultGameobjectContext implements IGameObjectContext 
	{
		private var _collide:Strategy;
		
		private var _destroy:Strategy;
		
		private var _creation:Strategy;
		
		public function DefaultGameobjectContext() 
		{
			
		}
		
		public function get creation():Strategy 
		{
			return _creation;
		}
		
		public function set creation(value:Strategy):void 
		{
			_creation = value;
		}
		
		public function get destroy():Strategy 
		{
			return _destroy;
		}
		
		public function set destroy(value:Strategy):void 
		{
			_destroy = value;
		}
		
		public function get collide():Strategy 
		{
			return _collide;
		}
		
		public function set collide(value:Strategy):void 
		{
			_collide = value;
		}
		
		
		
	}

}