package utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class DimensionalMath 
	{
		
		public function DimensionalMath() 
		{
			
		}
		
		public static function inRadius(radius:Number, appliationPoint:Point, interestPoint:Point):Boolean
		{
			return distance(appliationPoint, interestPoint) < radius;
		}
		
		public static function distance(point1:Point, point2:Point):Number
		{
			var pow1:Number = (point1.x - point2.x);
			pow1 *= pow1;
			
			var pow2:Number = (point1.y - point2.y);
			pow2 *= pow2;
			
			return Math.sqrt(pow1 + pow2);
		}
		
	}

}