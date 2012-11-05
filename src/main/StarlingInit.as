package
{
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import starling.core.Starling;
	
	
	
	public class StarlingInit extends Sprite
	{
		private var mStarling:Starling;
		public static var debugInstance:Sprite
		
		public function StarlingInit()
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			debugInstance = new Sprite();
			
			//stateManager.nextState(loadState);
			
			TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);

			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <BitmapData>[new BitmapData(1, 1, true, 0x01000000)];
			Mouse.registerCursor('noCursor', cursor);

			
			mStarling = new Starling(MainStarlingScene, stage);
			
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = false;
			mStarling.start();
			mStarling.showStats = true;
			
			//mStarling.showStats = true;
			// this event is dispatched when stage3D is set up
			mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			//stage.addChild(debugInstance);
			stage.quality = StageQuality.MEDIUM
			
		}
		
		private function onContextCreated(event:Event):void
		{
			var driver:TextField = new TextField();
			addChild(driver);
			driver.text = Starling.context.driverInfo.toLowerCase();
			driver.textColor = 0xFFFFFF;
			driver.autoSize = TextFieldAutoSize.LEFT;
			driver.x = stage.stageWidth - driver.textWidth - 2;
			// set framerate to 30 in software mode
			Starling.current.nativeStage.frameRate = 60;
			if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				Starling.current.nativeStage.frameRate = 30;
			
		
		}
	}
}