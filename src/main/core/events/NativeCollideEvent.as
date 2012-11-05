package core.events 
{
	import Box2D.Dynamics.b2Body;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class NativeCollideEvent extends Event 
	{
		public static const PHYSIC_BODY_COLLIDE:String = 'pBodyCol';
		
		private var _bodyA:b2Body;
		private var _bodyB:b2Body;
		
		public function NativeCollideEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bodyA:b2Body = null, bodyB:b2Body = null) 
		{
			super(type, bubbles, cancelable);
			this.bodyB = bodyB;
			this.bodyA = bodyA;
			
		}
		
	
		
		public function get bodyA():b2Body 
		{
			return _bodyA;
		}
		
		public function set bodyA(value:b2Body):void 
		{
			_bodyA = value;
		}
		
		public function get bodyB():b2Body 
		{
			return _bodyB;
		}
		
		public function set bodyB(value:b2Body):void 
		{
			_bodyB = value;
		}
		
	}

}