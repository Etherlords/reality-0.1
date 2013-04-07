package core.ioc 
{
	import core.collections.SimpleMap;
	import core.ioc.analyzator.MetatagProcessor;
	import core.ioc.analyzator.Metatags;
	import core.ioc.metacommands.Inject;
	import core.services.AbstractService;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Context 
	{
		private static var _instance:Context;
		
		static public function get instance():Context 
		{
			if (!_instance)
				_instance = new Context();
			
			return _instance;
		}
		
		public var settings:ContextSettings = new ContextSettings();
		
		private var metatagProcessor:MetatagProcessor;
		private var objectByType:SimpleMap = new SimpleMap();
		private var objectsByIdent:SimpleMap = new SimpleMap();
		
		public function Context() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			Metatags.PROCESSED_TAGS.push(Inject);
			
			metatagProcessor = new MetatagProcessor(this);
		}
		
		public function init():void
		{
			
		}
		
		public function inject(object:Object):void
		{
			metatagProcessor.process(object);
		}
		
		public function addObjectToContext(object:Object, idnet:String = ''):void
		{
			inject(object);
			
			if (idnet.length)
				objectsByIdent.addItem(idnet, object);
				
			objectByType.addItem(getQualifiedClassName(object), object);
		}
		
		public function registerService(service:Class):void
		{
			var serviceInstance:AbstractService = new service();
			
			addObjectToContext(serviceInstance);
		}
		
		public function getObjectByType(methodType:String):Object 
		{
			return objectByType.getItem(methodType);
		}
		
	}

}