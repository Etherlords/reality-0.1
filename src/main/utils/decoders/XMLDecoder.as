package utils.decoders 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

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
		
		public function decode(data:ByteArray, filename:String = null):void 
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