package patterns.strategy 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Strategy 
	{
		protected var _protect:Boolean;
		protected var _isFunctionStrategy:Boolean;
		protected var _numberOfArguments:int;
		
		protected var _algorithm:Object;
		protected var _key:String;
		
		public function Strategy(key:String, algorithm:Object, protect:Boolean = false) 
		{
			_protect = protect;
			_key = key;
			_algorithm = algorithm;
			
			init();
		}
		
		protected function init():void 
		{
			_isFunctionStrategy = _algorithm is Function;
			_numberOfArguments = _algorithm.length
		}
		
		public function execute(args:Array = null):*
		{	
			
			return _algorithm.apply(this, args);
		}
		
		public function get isFunctionStrategy():Boolean 
		{
			return _isFunctionStrategy;
		}
		
		public function get numberOfArguments():int 
		{
			return _numberOfArguments;
		}
		
		public function get key():String 
		{
			return _key;
		}
		
		public function get protect():Boolean 
		{
			return _protect;
		}
		
	}

}