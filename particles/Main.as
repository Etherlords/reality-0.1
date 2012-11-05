package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Shiu
	 */
	[SWF(width = 400, height = 300)]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//choose programs to switch to
			var myStarling:Starling = new Starling(Testing, stage);
			//var myStarling:Starling = new Starling(TestingShip, stage);
			//var myStarling:Starling = new Starling(TestingEnvironment, stage);
			//var myStarling:Starling = new Starling(TestingBurn, stage);
			//var myStarling:Starling = new Starling(TestingExplosion, stage);
			
			myStarling.simulateMultitouch = true;
			myStarling.start();
			
			//initiate Starling onto stage
			//allow mouse/ touch events to happen in Starling
			//turn key and start the engine!
		}
		
	}
	
}