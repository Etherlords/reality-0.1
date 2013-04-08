package core.ioc.cashe 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class MethodInfo 
	{
		private var _methodName:String;
		private var _methodType:String;
		private var _metaType:String;
		
		public function MethodInfo(methodName:String, methodType:String, metaType:String) 
		{
			_metaType = metaType;
			_methodType = methodType;
			_methodName = methodName;
			
		}
		
		public function get methodName():String 
		{
			return _methodName;
		}
		
		public function get methodType():String 
		{
			return _methodType;
		}
		
		public function get metaType():String 
		{
			return _metaType;
		}
		
	}

}