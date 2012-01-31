package ui.background.datavalues 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author 
	 */
	public class BackgroundModel 
	{
		
		private var _backgroundSource:BitmapData;
		private var _backgroundKey:String;
		private var _backgroundStartY:Number
		
		public function BackgroundModel(source:BitmapData, startY:Number, key:String = '') 
		{
			_backgroundSource = source;
			_backgroundKey = key;
			_backgroundStartY = startY;
		}
		
		public function get backgroundSource():BitmapData 
		{
			return _backgroundSource;
		}
		
		public function get backgroundKey():String 
		{
			return _backgroundKey;
		}
		
		public function get backgroundStartY():Number 
		{
			return _backgroundStartY;
		}
		
	}

}