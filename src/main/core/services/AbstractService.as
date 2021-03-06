package core.services
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author
	 */
	public class AbstractService extends EventDispatcher
	{
		
		private static var _serviceName:String;
		
		public function AbstractService()
		{
			internalInitilize();
		}
		
		private function internalInitilize():void
		{
			_serviceName = getQualifiedClassName(this);
			register()
		}
		
		private function register():void 
		{
			//ServicesLocator.instance.addService(this);
		}
		
		public function get serviceName():String
		{
			return _serviceName;
		}
	}

}