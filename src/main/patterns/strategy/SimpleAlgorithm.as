package patterns.strategy 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class SimpleAlgorithm extends Object implements IAlgorithm
	{
		private var _executeMethod:Function;
		
		
		public function SimpleAlgorithm() 
		{
			super();
			
			if (!this.hasOwnProperty('execute'))
				throw(new Error('strategy algorithm or child must have public field "execute"'));
				
		}
		
		public function apply(scope:Object = null, args:Array = null):* 
		{
			return this['execute'].apply(scope, args);
		}
		
		public function get length():int 
		{
			return this['execute'].length;
		}
	}

}