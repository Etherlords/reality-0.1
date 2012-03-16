package core.view.gameobject.context 
{

	import core.view.direction.Direction;
	import core.view.gameobject.body.IBodyPresentation;
	import core.view.gameobject.physicalpropeties.IPhysicalProperties;
	/**
	 * ...
	 * @author 
	 */
	public class GameobjectContext 
	{
		
		private var _direction:Direction;
		private var _body:IBodyPresentation;
		private var _physicalProperties:IPhysicalProperties;
		
		public function GameobjectContext() 
		{
			
		}
		
		public function get direction():Direction 
		{
			return _direction;
		}
		
		public function set direction(value:Direction):void 
		{
			_direction = value;
		}
		
		public function get body():IBodyPresentation 
		{
			return _body;
		}
		
		public function set body(value:IBodyPresentation):void 
		{
			_body = value;
		}
		
		public function get physicalProperties():IPhysicalProperties 
		{
			return _physicalProperties;
		}
		
		public function set physicalProperties(value:IPhysicalProperties):void 
		{
			_physicalProperties = value;
		}
		
	}

}