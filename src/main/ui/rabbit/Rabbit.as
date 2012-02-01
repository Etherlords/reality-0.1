package ui.rabbit 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		
		
		public function Rabbit(config:GameobjectConfig, instance:Sprite) 
		{
			super(config, instance);
		}
		
		public function applyMove(force:Number):void
		{
			physicalProperties.stopXVelocity();
			physicalProperties.applyImpulse(force, 0);
		}
    }

}