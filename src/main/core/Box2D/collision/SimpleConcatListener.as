package core.Box2D.collision 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import core.events.NativeCollideEvent;
	import core.locators.PhysicWorldLocator;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class SimpleConcatListener extends b2ContactListener implements IEventDispatcher
	{
		private var dispatcher:EventDispatcher;
		private var eventFlowTarget:IEventDispatcher;
		
		public function SimpleConcatListener(eventFlowTarget:IEventDispatcher = null) 
		{
			this.eventFlowTarget = eventFlowTarget;
			initilize();
		}
		
		private function initilize():void 
		{
			dispatcher = new EventDispatcher(eventFlowTarget);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return dispatcher.willTrigger(type);
		}
		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var bodyA:b2Body = contact.GetFixtureA().GetBody();
			var bodyB:b2Body = contact.GetFixtureB().GetBody();
			
			dispatchEvent(new NativeCollideEvent(NativeCollideEvent.PHYSIC_BODY_COLLIDE, true, false, bodyA, bodyB));
		}
		
		
		
		
		
	}

}