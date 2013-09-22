package utils.decoders 
{
	import flash.events.IEventDispatcher;
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
	
	
	public interface IDecoder extends IEventDispatcher
	{
		
		function decode(data:ByteArray, filename:String = null):void
		function get data():*
		function destroy():void
	}
	
}