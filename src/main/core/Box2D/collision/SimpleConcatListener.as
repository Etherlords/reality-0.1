package core.Box2D.collision 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
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
			//Можно баблить эвенты если это понадобится задав выше стоящий во флоу диспатчер
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
		
		//This is called when two fixtures begin to overlap. This is called for sensors and non-sensors. This event can only occur inside the time step.
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			/**
			 * В нашем случае я беру 2 физических боди которые столкнулись A, B и диспатчу эвент говорящий о том что было соврешено нативное столкновение
			 * столкновение боди в физ движке
			 */
			var bodyA:b2Body = contact.GetFixtureA().GetBody();
			var bodyB:b2Body = contact.GetFixtureB().GetBody();
			
			dispatchEvent(new NativeCollideEvent(NativeCollideEvent.PHYSIC_BODY_COLLIDE, true, false, bodyA, bodyB));
		}
		
		//This is called when two fixtures cease to overlap. This is called for sensors and non-sensors. This may be called when a body is destroyed, so this event can occur outside the time step.
		override public function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
		}
		
		//This is called after collision detection, but before collision resolution. This gives you a chance to disable the contact based on the current configuration. For example, you can implement a one-sided platform using this callback and calling b2Contact::SetEnabled(false). The contact will be re-enabled each time through collision processing, so you will need to disable the contact every time-step. The pre-solve event may be fired multiple times per time step per contact due to continuous collision detection.
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			/**
			 * Пре солв используем для обработки события столкновения до того как оно произашло 
			 * но по расчетам оно уже произайдет
			 * Тут мы можем какую то спецэфическу обработку сделать
			 * или отменить столкновение вообще
			 * 
			 * Типа ввести фильтры на коллайды говоряшие что какие то объекты не могут сталкиватся с другими а каике то могут
			 */
			super.PreSolve(contact, oldManifold);
		}
		
		//The post solve event is where you can gather collision impulse results. If you don’t care about the impulses, you should probably just implement the pre-solve event.
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			/**
			 * Используется для пост обработки коллайда, например на бегин конкат, на мы не можем удалить боди т.к
			 * оно залочено из за того что участвует в столкновении
			 * но в пост солве мы уже можем это делать
			 */
			
			/**
			 * The recommended practice for processing contact points is to buffer all contact data that you care about and process it after the time step. 
			 * You should always process the contact points immediately after the time step; otherwise some other client code might alter the physics world, invalidating the contact buffer. 
			 * When you process the contact buffer you can alter the physics world, but you still need to be careful that you don't orphan pointers stored in the contact point buffer.
			 * The testbed has example contact point processing that is safe from orphaned pointers.
			 */
			super.PostSolve(contact, impulse);
		}
		
		
		
		
		
	}

}