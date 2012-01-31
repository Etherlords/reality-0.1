package ui.snow 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Snow extends Sprite 
	{
		private var sinInterval:Number = 0.05 + Math.random() * 0.15;
		private var t:Number = 0;
		private var speed:Number = Math.random() + 0.5;
		
		private var dieTimer:Timer = new Timer(13000, 1);
		
		public function Snow() 
		{
			this.graphics.lineStyle(2, 0xFFFFFF, 0.9);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(1, 0);
			
			dieTimer.addEventListener(TimerEvent.TIMER_COMPLETE, destroy);
			dieTimer.start();
			
			this.addEventListener(Event.ENTER_FRAME, onUpdateFrame);
		}
		
		private function destroy(e:TimerEvent):void 
		{
			
			dieTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, destroy);
			
			TweenLite.to(this, 1, { alpha:0, onComplete:fullyRemove});
		}
		
		private function fullyRemove():void 
		{
			this.removeEventListener(Event.ENTER_FRAME, onUpdateFrame);
			dieTimer = null;
			TweenLite.killTweensOf(this);
			
			
			if (this.parent)
				parent.removeChild(this);
		}
		
		private function onUpdateFrame(e:Event):void 
		{
			this.y += speed;
			this.x += Math.sin(t += sinInterval);
		}
		
	}

}