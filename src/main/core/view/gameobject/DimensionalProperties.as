package core.view.gameobject 
{
	import Box2D.Common.Math.b2Vec2;
	import core.body.IBodyPresentation;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class DimensionalProperties 
	{
		private var body:IBodyPresentation;
		
		private var _position:b2Vec2;
		
		public function DimensionalProperties(body:IBodyPresentation) 
		{
			this.body = body;
		}
		
		public function get x():Number
		{
			return body.x;
		}
		
		public function get y():Number
		{
			return body.y;
		}
		
		public function get position():Point
		{
			return body.position
		}
		
	}

}