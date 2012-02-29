package core.view.gameobject.physicalpropeties 
{
	import Box2D.Common.Math.b2Vec2;
	import core.view.gameobject.body.PhysicBodyPresentation;

	
	import flash.geom.Point;

	/**
	 * ...
	 * @author 
	 */
	public class SimplePhysicalProperties implements IPhysicalProperties 
	{
		private var body:PhysicBodyPresentation;
		private var _physicModel:PhysicModel;
		
		public function SimplePhysicalProperties(body:PhysicBodyPresentation, physicModel:PhysicModel)
		{
			this._physicModel = physicModel;
			this.body = body;
			
			initilize();
		}
		
		private function initilize():void 
		{
			_physicModel.setBody(body.body);
		}

		public function stopXVelocity():void 
		{
			var linearVelocity:Point = _physicModel.linearVelocity;
			linearVelocity.x = 0;

			_physicModel.linearVelocity = linearVelocity;
		}

		public function stopYVelocity():void 
		{
			var linearVelocity:Point = _physicModel.linearVelocity;
			linearVelocity.y = 0;

			_physicModel.linearVelocity = linearVelocity;
		}
		
		public function applyForce(x:Number = 0, y:Number = 0, forceSourceX:Number = 0, iforceSourceY:Number = 0):void 
		{
			body.body.ApplyForce(new b2Vec2(x, y), new b2Vec2(forceSourceX, iforceSourceY));
		}

		public function applyImpulse(x:Number = 0, y:Number = 0, impulseSourceX:Number = 0, impulseSourceY:Number = 0):void 
		{
			body.body.ApplyImpulse(new b2Vec2(x, y), new b2Vec2(impulseSourceX, impulseSourceY));
		}

		public function get physicBodyKey():*
		{
			return body.body;
		}
		
		public function get physicModel():PhysicModel 
		{
			return _physicModel;
		}

	}

}