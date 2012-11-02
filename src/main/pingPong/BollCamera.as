package pingPong 
{
	import flash.geom.Point;
	import ui.camera.TracingCamera;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class BollCamera extends TracingCamera 
	{
		private var pointOfView:Point;
		
		public function BollCamera(tracingTarget:Object = null, pointOfView:Point = null ) 
		{
			super(tracingTarget);
			this.pointOfView = pointOfView;
			
		}
		
		override protected function centerOnTarget():void 
		{
			if (!_tracingTarget)
				return;
			
			_target.x = tracingTarget.body.x + tracingTarget.body.width;
			_target.y = tracingTarget.body.y + tracingTarget.body.height / 2;
			
			_target.x /= 20;
			_target.y /= 100;
			
			//trace(tracingTarget.body.x + tracingTarget.body.width );
			
			_target.x += pointOfView.x;
			_target.y += pointOfView.y;
		}
	}

}