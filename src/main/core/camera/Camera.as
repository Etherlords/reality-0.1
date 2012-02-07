package core.camera 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Camera 
	{
		
		protected var _target:Point
		
		public function Camera() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			_target = new Point();
		}
		
		public function get target():Point 
		{
			return _target;
		}
		
		public function set target(value:Point):void 
		{
			_target = value;
		}
		
	}

}