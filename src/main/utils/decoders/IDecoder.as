package utils.decoders 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author 
	 */
	
	/**
	 * Decoder complete 
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")] 
	
	
	public interface IDecoder 
	{
		function addEventListener(type:String, listener:Function):void
		function decode(data:ByteArray):void
		function get data():*
		function destroy():void
	}
	
}