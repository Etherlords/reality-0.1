package core.services
{
	import core.collections.SimpleMap;
	import core.services.AbstractService;
	import utils.getClassOfObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	
	/**
	 * ...
	 * @author
	 */
	public class ServicesLocator
	{
		
		/**
		 * TODO: Вынести локатор из CORE в CORE оставить только базовый класс
		 */
		private static var _instance:ServicesLocator;
		private var classMap:SimpleMap;
		//private var nameMap:SimpleMap;
		
		public function ServicesLocator()
		{
			initilize();
		}
		
		private function initilize():void
		{
			classMap = new SimpleMap();
			//nameMap = new SimpleMap();
		}
		
		static public function get instance():ServicesLocator
		{
			if (!_instance)
				_instance = new ServicesLocator();
			
			return _instance;
		}
		
		public function addService(service:AbstractService):void
		{
			addServiceAs(service);
		}
		
		public function addServiceAs(service:AbstractService):void
		{
			var serviceClass:Class = getClassOfObject(service);
			
			addInstanceAsClass(service, serviceClass);
			
			service.registred(this);
		}
		
		private function addInstanceAsClass(instance:AbstractService, targetClass:Class):void
		{
			classMap.addItem(getQualifiedClassName(targetClass), instance);
		}
		
		public function getService(service:Class):AbstractService
		{
			return getInstanceByClass(service);
		}
		
		private function getInstanceByClass(targetClass:Class):AbstractService
		{
			return classMap.getItem(getQualifiedClassName(targetClass));
		}
	}

}