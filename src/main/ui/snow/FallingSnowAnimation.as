package ui.snow 
{
	import flash.display.Sprite;
	import starling.events.Event;
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
		private var _drawingX:Number = 0;
		
		public function FallingSnowAnimation(convasWidth:Number) 
		{
			this.convasWidth = convasWidth;
			
			initilize();
		}
		
		private function initilize():void 
		{
			var timer:Timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, generateSnow);
			timer.start();
			
			//addEventListener(Event.ENTER_FRAME, onFrameEnter)
		}
		
		private function onFrameEnter(e:Event):void 
		{
			var len:int = numChildren - 1
			for (var i:int = 0; i < numChildren - 1; i++)
			{
				//(getChildAt(i) as Snow).updateView()
			}
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
		
		public function get drawingX():Number 
		{
			return _drawingX;
		}
		
		public function set drawingX(value:Number):void 
		{
			_drawingX = value;
		}
		
		private function generateSnow(e:TimerEvent = null):void 
		{
			//trace(_drawingY);
			var snow:Snow = new Snow();
			addChild(snow);
			snow.x = Math.random() * convasWidth -_drawingX;
			snow.y = -_drawingY;
			
			//snow.addEventListener("destroy", removeSnow);
		}
		
		private function removeSnow(e:Event):void 
		{
			
		}
		
	}

}