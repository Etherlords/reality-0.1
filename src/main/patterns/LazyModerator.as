package patterns 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import patterns.events.LazyModeratorEvent;
	/**
	 * ...
	 * @author Nikro
	 */
	
	/**
	 * @eventType	patterns.events.LazyModeratorEvent.UPDATE_EVENT
	 */
	[Event(name="moderatorUpdateEvent", type="patterns.events.LazyModeratorEvent")] 
	 
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
			updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dispatchUpdate);
		}
		
		private function dispatchUpdate(e:TimerEvent):void 
		{
			dispatchEvent(new LazyModeratorEvent(LazyModeratorEvent.UPDATE_EVENT));
			cleanFields();
		}
		
		override public function moderateField(str:String):void 
		{
			super.moderateField(str);
			
			if(!updateTimer.running)
				updateTimer.start();
		}
		
	}

}