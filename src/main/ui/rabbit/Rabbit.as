package ui.rabbit 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

import core.Box2D.utils.BodyConstructor;

import core.Box2D.utils.PhysicBodyConstructor;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;

/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		
		
		public function Rabbit(construcor:BodyConstructor)
		{
			super(construcor);
		}
		
		public function applyMove(force:Number):void
		{
			var linearVelocity:b2Vec2 = body.GetLinearVelocity();
			linearVelocity.Set(0, linearVelocity.y);
			
			applyImpulseFromCenter(new b2Vec2(force, 0));
		}
	
		
		
	}

}