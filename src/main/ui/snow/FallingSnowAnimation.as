package ui.snow 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class FallingSnowAnimation extends Sprite 
	{
		private var convasWidth:Number;
		private var _drawingY:Number = 0;
		
		public function FallingSnowAnimation(convasWidth:Number) 
		{
			this.convasWidth = convasWidth;
			
			initilize();
		}
		
		private function initilize():void 
		{
			var timer:Timer = new Timer(300);
			timer.addEventListener(TimerEvent.TIMER, generateSnow);
			timer.start();
		}
		
		public function set drawingY(value:Number):void
		{
			if (_drawingY == value)
				return;
			
			_drawingY = value;
			generateSnow()
		}
		
		public function get drawingY():Number 
		{
			return _drawingY;
		}
		
		private function generateSnow(e:TimerEvent = null):void 
		{
			//trace(_drawingY);
			var snow:Snow = new Snow();
			addChild(snow);
			snow.x = Math.random() * convasWidth;
			snow.y = -_drawingY;
		}
		
	}

}