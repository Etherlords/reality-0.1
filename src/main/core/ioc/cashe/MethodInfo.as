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
		
		public function MethodInfo(methodName:String, methodType:String) 
		{
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
		
	}

}