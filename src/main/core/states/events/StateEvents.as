package core.states.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class StateEvents extends Event 
	{
		/**
		 * Эвент сообщающий о том что стейт появился на сцене и стал активным
		 */
		public static const STATE_ENTRY:String = 'entry-state';
		
		/**
		 * Эвент сообщяющий о том что стейт выполнил свое условия выхода
		 * стал неактивным и ушел со сцены
		 */
		public static const STATE_OUT:String = 'out-state';
		
		/**
		 * Эвент гооврящий о том что стейт был проиницилизирован
		 */
		public static const STATE_INITILIZED:String = 'initilized-state'
		
		public function StateEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}