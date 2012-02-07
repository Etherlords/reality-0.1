package utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class BitMask 
	{
		private var mask:uint;
		
		public function BitMask(mask:uint = 0) 
		{
			this.mask = mask;
			initilize();
		}
		
		private function initilize():void 
		{
			
		}
		
		public function invertBit(bitIndex:uint):void
		{
			mask ^= (1 << bitIndex);
		}
		
		public function clearBit(bitIndex:uint):void
		{
			mask &= ~(1 << bitIndex);
		}
		
		public function setBit(bitIndex:uint):void
		{
			mask |= (1 << bitIndex);
		}
		
		public function isByteSet(bitIndex:uint):Boolean
		{
			return Boolean(mask & ( 1 << bitIndex));
		}
	}

}