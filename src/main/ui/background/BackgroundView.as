package ui.background 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author 
	 */
	public class BackgroundView extends Bitmap 
	{
		
		public function BackgroundView(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false) 
		{
			super(bitmapData, pixelSnapping, smoothing);
			
		}
		
	}

}