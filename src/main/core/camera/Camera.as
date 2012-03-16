package core.camera 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Camera 
	{
		/**
		 * TODO 
		 * Камера наверно будет модифицирована и добавится z индекс для определения какой слой мы сейчас видимо и степени движения
		 * различных слоев на бек граунде
		 */
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