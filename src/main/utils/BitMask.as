package utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class BitMask 
	{
		private var _mask:uint;
		
		public function BitMask(mask:uint = 0) 
		{
			_mask = mask;
			initilize();
		}
		
		public function setMask(mask:uint):void
		{
			_mask = mask;
		}
		
		private function initilize():void 
		{
			
		}
		
		public function invertBit(bitIndex:uint):void
		{
			_mask ^= (1 << bitIndex);
		}
		
		public function clearBit(bitIndex:uint):void
		{
			_mask &= ~(1 << bitIndex);
		}
		
		public function setBit(bitIndex:uint):void
		{
			_mask |= (1 << bitIndex);
		}
		
		public function isBitSet(bitIndex:uint):Boolean
		{
			return Boolean(_mask & ( 1 << bitIndex));
		}
		
		public function get mask():uint 
		{
			return _mask;
		}
	}

}