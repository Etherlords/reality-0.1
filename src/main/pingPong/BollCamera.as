package pingPong 
{
	import Box2D.Dynamics.b2Body;
	import core.GlobalConstants;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
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
				
			var body:b2Body = (tracingTarget.physicalProperties as SimplePhysicalProperties).physicBodyKey
			
			_target.x = body.GetWorldCenter().x * GlobalConstants.METRS_TO_PIXEL+ 50;
			_target.y = body.GetWorldCenter().y * GlobalConstants.METRS_TO_PIXEL+ 50 / 2;
			
			_target.x /= 40;
			_target.y /= 100;
			
			//trace(tracingTarget.body.x + tracingTarget.body.width );
			
			_target.x += pointOfView.x;
			_target.y += pointOfView.y;
		}
	}

}