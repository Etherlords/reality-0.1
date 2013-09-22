package utils.decoders 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author 
	 */
	public class ATFDecoder extends EventDispatcher implements IDecoder
	{
		private var _data:*;
		
		public function ATFDecoder() 
		{
			
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function decode(data:ByteArray):void 
		{
			_data = data
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function destroy():void 
		{
			_data = null;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
	}

}