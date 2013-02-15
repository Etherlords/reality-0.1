package core.services
{
	import core.services.ServicesLocator;
	
	import flash.events.EventDispatcher;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author
	 */
	public class AbstractService extends EventDispatcher
	{
		public static function getItself():AbstractService
		{
			return ServicesLocator.instance.getServiceByName(_serviceName)
		}
		
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
			ServicesLocator.instance.addService(this);
		}
		
		public function get serviceName():String
		{
			return _serviceName;
		}
		
		public function registred(serviceLocator:ServicesLocator):void
		{
			
		}
	
	}

}