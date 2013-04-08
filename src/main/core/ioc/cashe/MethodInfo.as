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
		private var _tagArgs:Object
		
		public function MethodInfo(methodName:String, methodType:String, metaType:String, tagArgs:Object) 
		{
			_tagArgs = tagArgs;
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
		
		public function get tagArgs():Object
		{
			return _tagArgs;
		}
		
	}

}