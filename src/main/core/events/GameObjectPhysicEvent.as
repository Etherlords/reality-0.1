package core.events 
{
	import core.view.gameobject.GameObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameObjectPhysicEvent extends Event 
	{
		public static const COLLIDE:String = 'collide';
		public static const DESTROY:String = 'destroy';
		
		private var _interactionWith:GameObject;
		
		public function GameObjectPhysicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, interactionWith:GameObject = null) 
		{
			super(type, bubbles, cancelable);
			_interactionWith = interactionWith;
		}
		
		override public function clone():Event 
		{
			return new GameObjectPhysicEvent(type, bubbles, cancelable, interactionWith);
		}
		
		public function get interactionWith():GameObject 
		{
			return _interactionWith;
		}
		
		public function set interactionWith(value:GameObject):void 
		{
			_interactionWith = value;
		}
		
	}

}