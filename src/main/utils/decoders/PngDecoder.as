package utils.decoders 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.utils.ByteArray;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class PngDecoder extends EventDispatcher implements IDecoder
	{
		private var loader:Loader;
		private var _data:*;
		
		public function PngDecoder() 
		{
			
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function decode(data:ByteArray):void 
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.loadBytes(data);
		}
		
		/* INTERFACE utils.decoders.IDecoder */
		
		public function destroy():void 
		{
			_data = null;
			loader = null;
		}
		
		private function onComplete(e:*):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			
			var bitmap:BitmapData = (loader.content as Bitmap).bitmapData;
			_data = bitmap;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get data():* 
		{
			return _data;
		}
		
	}

}