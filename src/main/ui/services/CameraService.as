package ui.services 
{
	import core.camera.Camera;
	import core.services.AbstractService;
	import flash.geom.Point;
	import ui.camera.TracingCamera;
	
	/**
	 * ...
	 * @author 
	 */
	public class CameraService extends AbstractService 
	{
		
		private var _camera:Camera
		
		public function CameraService(camera:Camera) 
		{
			super();
			this._camera = camera;
			
		}
		
		override protected function initilize():void 
		{
			super.initilize();
		}
		
		public function set cameraTarget(tracingTarget:Object):void
		{
			//_camera.tracingTarget = tracingTarget;
		}
		
		public function get camera():Camera 
		{
			return _camera;
		}
		
	}

}