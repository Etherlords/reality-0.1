package
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import pingPong.settings.PingPongSettingsModel;
	import pingPong.SharedObjectService;
	import starling.core.Starling;
	import utils.GlobalUIContext;
	
	
	
	public class StarlingInit extends Sprite
	{
		private var mStarling:Starling;
		private var sharedservice:SharedObjectService;
		
		public static var settings:PingPongSettingsModel;
		
		public function StarlingInit()
		{
			sharedservice = new SharedObjectService();
			settings = sharedservice.settings;
			
			initilizeContext();
			
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			

			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <BitmapData>[new BitmapData(1, 1, true, 0x01000000)];
			Mouse.registerCursor('noCursor', cursor);

			
			mStarling = new Starling(MainStarlingScene, stage, null, null, sharedservice.settings.isUseSoftwareBliting? Context3DRenderMode.SOFTWARE:Context3DRenderMode.AUTO);
			
			mStarling.simulateMultitouch = false;
			mStarling.antiAliasing = 0;
			mStarling.enableErrorChecking = false;
			
			mStarling.start();
			mStarling.showStats = true;
			
			mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			stage.quality = StageQuality.LOW
			
		}
		
		private function initilizeContext():void 
		{
			var topcontainer:DisplayObjectContainer = new Sprite();
			var debugContainer:DisplayObjectContainer = new Sprite();
			topcontainer.addChild(debugContainer);
			
			stage.addChild(topcontainer);
			
			GlobalUIContext.debugContainer = debugContainer;
			GlobalUIContext.vectorUIContainer = topcontainer;
			GlobalUIContext.vectorStage = stage;
		}
		
		private function onContextCreated(event:Event):void
		{
			var driver:TextField = new TextField();
			GlobalUIContext.vectorUIContainer.addChild(driver);
			
			driver.text = Starling.context.driverInfo.toLowerCase();
			driver.textColor = 0xFFFFFF;
			driver.autoSize = TextFieldAutoSize.LEFT;
			driver.x = stage.stageWidth - driver.textWidth - 2;
			// set framerate to 30 in software mode
			
		
		}
	}
}