package patterns.strategy
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class StrategyController
	{
		protected var strategies:/*Strategy*/Object;
		
		public function StrategyController() 
		{
			init();
		}
		
		private function init():void 
		{
			strategies = { };
		}
		
		public function addStrategy(strategy:Strategy):void
		{
			var key:String = strategy.key;
			var isProtected:Boolean = false;
			
			if (hasStrategy(key))
				isProtected = strategies[key].protect;
				
			if (!isProtected)
			{
				strategies[key] = strategy;
			}
			else
			{
				throw(new Error('try to override protected strategy'));
			}
		}
		
		public function removeStrategy(key:String):void
		{
			strategies[key] = null;
		}
		
		public function hasStrategy(key:String):Boolean
		{
			return strategies.hasOwnProperty(key);
		}
		
		public function crateNewStrategy(key:String, algorithm:*, protect:Boolean = false):void
		{
			addStrategy(new Strategy(key, algorithm, protect));
		}
		
		public function execute(key:String, ...args:Array):*
		{
			
			if(hasStrategy(key))
				return strategies[key].execute.apply(null, args);
			else
				return null;
		}
		
	}

}