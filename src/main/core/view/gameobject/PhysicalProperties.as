package core.view.gameobject 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import core.body.PhysicBodyPresentation;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicalProperties 
	{
		private var body:PhysicBodyPresentation;
		
		public function PhysicalProperties(body:PhysicBodyPresentation) 
		{
			this.body = body;
			
			initilize();
		}
		
		private function initilize():void 
		{
			
		}
		
		/**
		 * Пока хз как сделать лучше но нужен контроль за ускорением временами
		 * Хотя если инкапсулировать работу с боксом тут а наружу выдавать лишь интерфепйс
		 * из поинтов и методов то ОК вроде
		 */
		public function stopXVelocity():void
		{
			var linearVelocity:Point = this.linearVelocity;
			linearVelocity.x = 0;
			
			this.linearVelocity = linearVelocity;
		}
		
		public function stopYVelocity():void
		{
			var linearVelocity:Point = this.linearVelocity;
			linearVelocity.y = 0;
			
			this.linearVelocity = linearVelocity;
		}
		
		public function set linearVelocity(value:Point):void
		{
			body.body.SetLinearVelocity(new b2Vec2(value.x, value.y));
		}
		
		public function get linearVelocity():Point
		{
			var linearVelocity:b2Vec2 = body.body.GetLinearVelocity();
			return new Point(linearVelocity.x, linearVelocity.y);
		}
		
		public function applyImpulse(x:Number = 0, y:Number = 0, impulseSourceX:Number = 0, impulseSourceY:Number = 0):void
		{
			body.body.ApplyImpulse(new b2Vec2(x, y), new b2Vec2(impulseSourceX, impulseSourceY));
		}
		
		
		
	}

}