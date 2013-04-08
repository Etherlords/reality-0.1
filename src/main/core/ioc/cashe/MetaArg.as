package core.ioc.cashe 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class MetaArg 
	{
		private var _value:String;
		private var _argName:String;
		
		public function MetaArg(argName:String, value:String) 
		{
			_argName = argName;
			_value = value;
			
		}
		
		public function get argName():String 
		{
			return _argName;
		}
		
		public function get value():String 
		{
			return _value;
		}
		
		public function toString():String
		{
			return '[MetaArg(argName = ' + _argName + ', value = ' + _value + ')]';
		}
		
	}

}