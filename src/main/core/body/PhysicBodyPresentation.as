package core.body 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import core.GlobalConstants;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyPresentation implements IBodyPresentation 
	{
		private var body:b2Body;
		
		private var _position:b2Vec2;
		
		public function PhysicBodyPresentation(body:b2Body) 
		{
			this.body = body;
			
			initilize();
		}
		
		/* INTERFACE core.body.IBodyPresentation */
		
		public function get x():Number
		{
			return position.x;
		}
		
		public function set x(value:Number):void 
		{
			_position.Set(value / GlobalConstants.PIXELS_TO_METR, _position.y);
		}
		
		public function get y():Number
		{
			return position.y;
		}
		
		public function set y(value:Number):void 
		{
			_position.Set(_position.x, value / GlobalConstants.PIXELS_TO_METR);
		}
		
		public function get position():b2Vec2
		{
			var realPoint:b2Vec2 = _position.Copy();
			realPoint.Multiply(GlobalConstants.METRS_TO_PIXEL);
			
			return realPoint;
		}
		
		public function set position(value:Point):void 
		{
			var realPoint:b2Vec2 = new b2Vec2(value.x / GlobalConstants.PIXELS_TO_METR, value.y / GlobalConstants.PIXELS_TO_METR);
			
			body.SetPosition(realPoint);
		}
		
		public function get width():Number 
		{
			return 0;
		}
		
		public function set width(value:Number):void 
		{
			//_width = value;
		}
		
		public function get height():Number 
		{
			return 0;
		}
		
		public function set height(value:Number):void 
		{
			//_height = value;
		}
		
		private function initilize():void 
		{
			_position = body.GetPosition();
		}
		
	}

}