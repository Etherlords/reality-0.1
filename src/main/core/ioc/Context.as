package core.ioc 
{
  import core.collections.SimpleMap;
	import core.ioc.analyzator.MetatagProcessor;
	import core.ioc.analyzator.Metatags;
	import core.ioc.metacommands.Inject;
	import core.services.AbstractService;
	import flash.utils.describeType;
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
		public var metatags:Metatags = new Metatags();
		
		private var metatagProcessor:MetatagProcessor;
		private var objectByType:SimpleMap = new SimpleMap();
		private var objectByIface:SimpleMap = new SimpleMap();
		private var objectsByIdent:SimpleMap = new SimpleMap();
		
		public function Context() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			metatags.addTag(Inject);
			
			metatagProcessor = new MetatagProcessor(this);
		}
		
		public function init():void
		{
			
		}
		
		public function inject(object:Object):void
		{
			metatagProcessor.process(object);
		}
		
		public function addObjectToContext(object:Object, ident:String = ''):Context
		{
			if (ident.length)
			{
				objectsByIdent.addItem(ident, object);
			}
				
			objectByType.addItem(getQualifiedClassName(object), object);
			
			var desc:XML = describeType(object);
			var iFaces:XMLList = desc..implementsInterface ;
			
			var l:int = iFaces.length()
			for (var i:int = 0; i < l; ++i)
				objectByIface.addItem(iFaces[i].@type, object);
			
			return this;
		}
		
		public function registerService(service:Class):Context
		{
			var serviceInstance:AbstractService = new service();
			
			addObjectToContext(serviceInstance);
			
			return this;
		}
		
		public function getObjectByInterface(iFace:String):Object
		{
			return objectByIface.getItem(iFace);
		}
		
		public function getObjectById(id:String):Object
		{
			return objectsByIdent.getItem(id);
		}
		
		public function getObjectByType(methodType:String):Object 
		{
			return objectByType.getItem(methodType);
		}
		
	}
 
}