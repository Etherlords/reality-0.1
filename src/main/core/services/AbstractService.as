package core.services 
{
	import core.locators.ServicesLocator;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author 
	 */
	public class AbstractService 
	{
		
		private static var _serviceName:String;
		
		public function AbstractService() 
		{
			initilize();
		}
		
		protected function initilize():void 
		{
			_serviceName = getQualifiedClassName(this);
			
			registerService();
		}
		
		private function registerService():void 
		{
			ServicesLocator.instance.addService(this);
		}
		
		public function get serviceName():String
		{
			return _serviceName;
		}
		
		static public function get serviceName():String 
		{
			return _serviceName;
		}
		
	}

}