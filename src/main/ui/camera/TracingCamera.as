package ui.camera 
{
	import core.camera.Camera;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class TracingCamera extends Camera 
	{
		private var _tracingTarget:Object;
		
		public function TracingCamera(tracingTarget:Object = null) 
		{
			super();
			this.tracingTarget = tracingTarget;
		}
		
		public override function get target():Point 
		{
			centerOnTarget();
			
			return _target;
		}
		
		private function centerOnTarget():void 
		{
			if (!_tracingTarget)
				return;
			
			_target.x = tracingTarget.x + tracingTarget.width / 2;
			_target.y = tracingTarget.y + tracingTarget.height / 2;
		}
		
		public override function set target(value:Point):void 
		{
			//NoSet becaus it is auto track camera
		}
		
		public function get tracingTarget():Object 
		{
			return _tracingTarget;
		}
		
		public function set tracingTarget(value:Object):void 
		{
			_tracingTarget = value;
		}
		
	}

}