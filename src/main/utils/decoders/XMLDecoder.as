package utils.decoders 
{
	import flash.utils.ByteArray;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class XMLDecoder extends EventDispatcher implements IDecoder
	{
		private var _data:*;
		
		public function XMLDecoder() 
		{
			
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function decode(data:ByteArray):void 
		{
			data.position = 0;
			_data = new XML(data.readUTFBytes(data.length));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function destroy():void 
		{
			//System.disposeXML(_data);
			_data = null
		}
		
		public function get data():* 
		{
			return _data;
		}
		
	}

}