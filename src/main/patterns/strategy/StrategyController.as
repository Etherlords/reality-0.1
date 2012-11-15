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
		
		public function destroy():void
		{
			for (var key:String in strategies)
			{
				strategies[key].destroy();
			}
			
			strategies = null;
		}
		
		public function addStrategy(key:*, strategy:Strategy):void
		{
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
		
		public function removeStrategy(key:*):void
		{
			strategies[key] = null;
		}
		
		public function hasStrategy(key:*):Boolean
		{
			return strategies.hasOwnProperty(key);
		}
		
		public function crateNewStrategy(key:*, algorithm:*, protect:Boolean = false):void
		{
			addStrategy(key, new Strategy(algorithm, protect));
		}
		
		public function execute(key:*, ...args:Array):*
		{
			if (hasStrategy(key))
				return strategies[key].execute.call(null, args);
			else
				return null;
		}
		
	}

}