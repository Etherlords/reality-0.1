package patterns.strategy 
{
	/**
	 * ...
	 * @author ...
	 */
	public class StrategyMask 
	{
		private var _mask:Vector.<String>;
		
		public function StrategyMask(mask:Vector.<String>) 
		{
			_mask = mask;
			
		}
		
		public function addToMask(value:String):void
		{
			_mask.push(value);
		}
		
		public function get mask():Vector.<String> 
		{
			return _mask;
		}
		
		public function set mask(value:Vector.<String>):void 
		{
			_mask = value;
		}
		
	}

}