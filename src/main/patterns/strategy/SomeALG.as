package patterns.strategy 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class SomeALG extends SimpleAlgorithm
	{
		
		public function SomeALG() 
		{
			super();
		}
		
		public function execute(a1:int, a2:int, a3:int):* 
		{
			return math(a1, a2, a3);
		}
		
		private function math(a1:int, a2:int, a3:int):int 
		{
			trace('britva', a1, a2, a3);
			return a1 + a2 + a3;
		}
		
	}

}