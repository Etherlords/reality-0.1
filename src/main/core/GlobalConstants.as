package core 
{
	import Box2D.Common.b2Settings;
	/**
	 * ...
	 * @author 
	 */
	public class GlobalConstants 
	{
		
		public static var METRS_TO_PIXEL:Number = 50;
		public static var PIXELS_TO_METR:Number = 1 / METRS_TO_PIXEL;
		
		public static var RAD_TO_DEGREE:Number = 180 / Math.PI;
		public static var DEGREE_TO_RAD:Number = Math.PI / 180;
        public static const ACTION_VIEW_WALK_RIGHT:uint = 1;
        public static const ACTION_VIEW_WALK_LEFT:uint = 2;
        public static const ACTION_VIEW_JUMP_LEFT:uint = 3;
        public static const ACTION_VIEW_JUMP_RIGHT:uint = 4;
        public static const ACTION_STRATEGY_JUMP:String = "standartJump";
        public static const ACTION_STRATEGY_FOLLOW_MOUSE:String = "followMouse";
        public static const ACTION_STRATEGY_ACCELERATE:String = "ACTION_STRATEGY_ACCELERATE";
		
		
	}

}