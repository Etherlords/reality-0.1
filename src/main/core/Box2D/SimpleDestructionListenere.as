package core.Box2D 
{
	import Box2D.Dynamics.b2DestructionListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Joints.b2Joint;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleDestructionListenere extends b2DestructionListener 
	{
		
		public function SimpleDestructionListenere() 
		{
			
		}
		
		/**
		* Called when any joint is about to be destroyed due
		* to the destruction of one of its attached bodies.
		*/
		override public virtual function SayGoodbyeJoint(joint:b2Joint) : void
		{
			//trace(joint);
		};

		/**
		* Called when any fixture is about to be destroyed due
		* to the destruction of its parent body.
		*/
		override public virtual function SayGoodbyeFixture(fixture:b2Fixture) : void
		{
			//trace(fixture);
			
		}
	}

}