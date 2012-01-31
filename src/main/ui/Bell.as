package ui 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

import core.Box2D.utils.PhysicBodyConstructor;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;

import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Bell extends GameObject 
	{
		private var t:Timer;
		
		public function Bell(bodyConstructor:PhysicBodyConstructor)
		{
			super(bodyConstructor);
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			isSensor = true;
			
			t = new Timer(25);
			t.addEventListener(TimerEvent.TIMER, flowerEffect);
			t.start();
		}
		
		override public function destroy():void 
		{
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, flowerEffect);
			t = null;
			
			
			super.destroy();
		}
		
		private function flowerEffect(e:TimerEvent):void
		{
			
			//this.applyImpulseFromCenter(new b2Vec2(0, -1));
			var linearVelocity:b2Vec2 = body.GetLinearVelocity();
			
			linearVelocity.Set(linearVelocity.x, 0.1);
		}
		
	}

}