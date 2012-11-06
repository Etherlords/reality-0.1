package utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Nikro
	 */
	public class GlobalUIContext 
	{
		public static var debugContainer:DisplayObjectContainer;
		
		public static var vectorUIContainer:DisplayObjectContainer;
		public static var vectorStage:Stage;
		
		public static var starlingInstance:Starling = Starling.current
		
	}

}