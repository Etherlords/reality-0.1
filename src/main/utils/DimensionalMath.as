package utils 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author 
	 */
	public class DimensionalMath 
	{
		
		public function DimensionalMath() 
		{
			
		}
		
		public static function getMovieVector(from:Vector3D, to:Vector3D, numberOfSteps:Number):Vector3D
		{
			var delta:Vector3D = to.subtract(from);// (from);
			delta.x /= numberOfSteps;
			delta.z /= numberOfSteps;
			
			return delta;
		}
		
		public static function inRadius(radius:Number, appliationPoint:Object, interestPoint:Object):Boolean
		{
			return distance(appliationPoint, interestPoint) < radius;
		}
		
		public static function distance(point1:Object, point2:Object):Number
		{
			var pow1:Number = (point1.x - point2.x);
			pow1 *= pow1;
			
			var pow2:Number = (point1.y - point2.y);
			pow2 *= pow2;
			
			return Math.sqrt(pow1 + pow2);
		}
		
		public static function angle(a:Object, b:Object):Number
		{
			var dx:Number = a.x - b.x;
			var dy:Number = a.y - b.y;

			return Math.atan2(dy,dx);  
        }
		
	}

}