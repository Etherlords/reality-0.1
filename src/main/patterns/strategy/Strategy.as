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
		
		public function Strategy(algorithm:Object, protect:Boolean = false) 
		{
			_protect = protect;
			_algorithm = algorithm;
			
			init();
		}
		
		public function destroy():void
		{
			_algorithm = null;
		}
		
		protected function init():void 
		{
			_isFunctionStrategy = _algorithm is Function;
			_numberOfArguments = _algorithm.length
		}
		
		public function execute(args:* = null):*
		{	
			//NOTE: litle cheat
			if (numberOfArguments < args.length)
				args = args.slice(0, numberOfArguments);
			
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
		
		public function get protect():Boolean 
		{
			return _protect;
		}
		
	}

}