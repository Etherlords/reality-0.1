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
		private var tracingTarget:Object;
		
		public function TracingCamera(tracingTarget:Object) 
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
			_target.x = tracingTarget.x + tracingTarget.width / 2;
			_target.y = tracingTarget.y + tracingTarget.height / 2;
		}
		
		public override function set target(value:Point):void 
		{
			//NoSet becaus it is auto track camera
		}
		
	}

}