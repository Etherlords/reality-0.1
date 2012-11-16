package patterns 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LazyModerator extends Moderator 
	{
		
		protected var updateInterval:Number;
		protected var updateTimer:Timer;
		
		public function LazyModerator(updateInterval:Number = 500) 
		{
			this.updateInterval = updateInterval;
			super();
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			updateTimer = new Timer(updateInterval, 1);
			updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, updateTime);
		}
		
		private function updateTime(e:TimerEvent):void 
		{
			dispatchUpdate();
		}
		
		override public function moderateField(str:String):void 
		{
			super.moderateField(str);
			
			if(!updateTimer.running)
				updateTimer.start();
		}
		
	}

}