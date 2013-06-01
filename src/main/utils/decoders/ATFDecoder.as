package utils.decoders 
{
	import flash.utils.ByteArray;
	import starling.events.Event;
	import starling.events.EventDispatcher;
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