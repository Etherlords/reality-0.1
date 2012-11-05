package  
{
	/**
	 * Math2
	 * Purpose: Provide extra Mathematical functions to extend core Actionscript Math class, 
	 * @author shiu
	 * @version 1.0	9 August 2011
	 */
	public class Math2 
	{
		/**
		 * Convert given degree into radian
		 * @param	deg Angle in degree
		 * @return Angle in radian
		 */
		public static function radianOf (deg:Number):Number
		{
			return deg/180*Math.PI;
		}
		
		/**
		 * Convert given radian into degree
		 * @param	rad	Angle in radian
		 * @return Angle in degree
		 */
		public static function degreeOf (rad:Number):Number
		{
			return rad/Math.PI*180;
		}
		
		/**
		 * Perform Pythagoras' Theorem on the following coordinates
		 * @param	x1 coordinateA, x
		 * @param	y1 coordinateA, y
		 * @param	x2 coordinateB, x
		 * @param	y2 coordinateB, y
		 * @return Length between coordinates
		 */
		public static function Pythagoras(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xdist:Number = x1-x2;
			var ydist:Number = y1-y2;
			 //Math2.degreeOf(Math.atan2(ydist,xdist))
			return Math.sqrt(xdist*xdist+ydist*ydist);
		}
		
		/**
		 * Perform cosine rule to obtain the angle sandwiched between a and b
		 * @param	x1 coordinateA, x
		 * @param	y1 coordinateA, y
		 * @param	x2 coordinateB, x
		 * @param	y2 coordinateB, y
		 * @param	x3 coordinateC, x
		 * @param	y3 coordinateC, y
		 * @return Angle in radian between CA and CB
		 */
		public static function cosineRule(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number):Number
		{
			var CA:Number = Pythagoras(x3, y3, x1, y1);
			var CB:Number = Pythagoras(x3, y3, x2, y2);
			var AB:Number = Pythagoras(x1, y1, x2, y2);
			
			var alpha:Number = Math.acos(( CA * CA + CB * CB - AB * AB ) / 2 * CA * CB);
			return alpha
		}
		
		/**
		 * Perform bounding of input value between two predefined boundaries
		 * @param	lowerBound Minimum to allow
		 * @param	upperBound Maximum to allow
		 * @param	input Current value to bound
		 * @return A value within boundaries
		 */
		public static function implementBound(lowerBound:Number, upperBound:Number, input:Number):Number
		{
			return Math.min(Math.max(lowerBound, input), upperBound);
		}
	}

}