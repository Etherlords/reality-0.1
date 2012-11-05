package ui.snow 
{
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import starling.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Snow extends Sprite 
	{
		private var sinInterval:Number = 0.05 + Math.random() * 0.03;
		private var t:Number = 0;
		private var speed:Number = Math.random() + 1.5;
		
		private var dieTimer:Timer = new Timer(6000, 1);
		
		public function Snow() 
		{
			//this.graphics.lineStyle(2, 0xFFFFFF, 0.9);
			//this.graphics.moveTo(0, 0);
			//this.graphics.lineTo(1, 0);
			
			var bitmap:Bitmap = new Bitmap(new SnowSprite1(), 'auto', true);
			addChild(bitmap);
			bitmap.x -= bitmap.width / 2;
			bitmap.y -= bitmap.height / 2;
			
			if(Math.random() > 0.7)
				this.filters = [new BlurFilter(6, 6)];
			
			this.scaleX = this.scaleY = 0.1 + Math.random();
			
			dieTimer.addEventListener(TimerEvent.TIMER_COMPLETE, destroy);
			dieTimer.start();
		}
		
		private function destroy(e:TimerEvent):void 
		{
			dieTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, destroy);
			
			TweenLite.to(this, 1, { alpha:0, onComplete:fullyRemove } );
			
		}
		
		private function fullyRemove():void 
		{
			dieTimer = null;
			TweenLite.killTweensOf(this);
			
			
			if (this.parent)
				parent.removeChild(this);
				
			//dispatchEvent(new Event("destroy"));
		}
		
		public function updateView():void
		{
			
			return;
			this.y += speed;
			
			this.x += 1//Math.sin(t += sinInterval) / 2;
		}
		
	}

}