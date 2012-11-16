package patterns 
{
	import flash.events.EventDispatcher;
	import patterns.events.LazyModeratorEvent;
	
	/**
	 * @eventType	patterns.events.LazyModeratorEvent.UPDATE_EVENT
	 */
	[Event(name="moderatorUpdateEvent", type="patterns.events.LazyModeratorEvent")] 
	public class Moderator extends EventDispatcher
	{
		protected var fieldsChanged:Object;
		
		public function Moderator() 
		{
			initilize();
		}
		
		protected function initilize():void 
		{
			cleanFields();
		}
		
		public function cleanFields():void
		{
			fieldsChanged = { };
		}
		
		public function getFieldsList():Object
		{
			return fieldsChanged
		}
		
		public function update():void
		{
			dispatchUpdate();
		}
		
		protected function dispatchUpdate():void 
		{
			dispatchEvent(new LazyModeratorEvent(LazyModeratorEvent.UPDATE_EVENT));
			cleanFields();
		}
		
		public function moderateField(str:String):void
		{
			fieldsChanged[str] = new int();
		}
		
	}

}