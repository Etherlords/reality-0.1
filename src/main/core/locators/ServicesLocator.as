package core.locators 
{
	import core.collections.SimpleMap;
	import core.services.AbstractService;
	import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;
	import ui.services.CameraService;
	import ui.services.ScoreboardService;
	/**
	 * ...
	 * @author 
	 */
	public class ServicesLocator 
	{
		private static var _instance:ServicesLocator;
		private var classMap:SimpleMap;
		private var nameMap:SimpleMap;
		
		public function ServicesLocator() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			classMap = new SimpleMap();
			nameMap = new SimpleMap();
		}
		
		public static function get scoreboardService():ScoreboardService
		{
			return instance.getServiceByClass(ScoreboardService) as ScoreboardService;
		}
		
		public static function get cameraService():CameraService
		{
			return instance.getServiceByClass(CameraService) as CameraService;
		}
		
		static public function get instance():ServicesLocator 
		{
			if (!_instance)
				_instance = new ServicesLocator();
			
			return _instance;
		}
		
		public function addService(service:AbstractService):void
		{
            var className:String = getQualifiedClassName(service);
            addServiceAs(service, getDefinitionByName( className ) as Class, service.serviceName);

		}

        public function addServiceAs(service:AbstractService, targetServiceClass:Class, targetServiceName:String = null):void {
            addInstanceAsClass(service, targetServiceClass);
            if (targetServiceName) {
                nameMap.addItem(targetServiceName, service);
            }
            service.registered(this);
        }
		
		public function getServiceByClass(serviceClass:Class):AbstractService
		{
			return getInstanceByClass(serviceClass);
		}


        private function addInstanceAsClass(instance:*, targetClass:Class):void {
            classMap.addItem(getQualifiedClassName(targetClass), instance);
        }

        private function getInstanceByClass(targetClass:Class):* {
           return classMap.getItem(getQualifiedClassName(targetClass));
        }
    }

}