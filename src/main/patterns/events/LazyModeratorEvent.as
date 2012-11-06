package patterns.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class LazyModeratorEvent extends Event
	{
		
		public static const UPDATE_EVENT:String = 'moderatorUpdateEvent';
		
		public function LazyModeratorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable)
		}
		
		override public function clone():Event 
		{
			return new LazyModeratorEvent(type, bubbles, cancelable);
		}
	}

}