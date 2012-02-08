package ui.services 
{
	import core.services.AbstractService;
	import ui.camera.TracingCamera;
	
	/**
	 * ...
	 * @author 
	 */
	public class CameraService extends AbstractService 
	{
		
		private var _camera:TracingCamera
		
		public function CameraService() 
		{
			super();
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			_camera = new TracingCamera();
		}
		
		public function set cameraTarget(tracingTarget:Object):void
		{
			_camera.tracingTarget = tracingTarget;
		}
		
		public function get camera():TracingCamera 
		{
			return _camera;
		}
		
	}

}