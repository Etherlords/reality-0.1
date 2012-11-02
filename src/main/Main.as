package  
{
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import ui.scene.gameInteractionScene.LoadGameController;
	import ui.scene.gameInteractionScene.PlatformerTest;


	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			
			initilzie();
		}
		
		private function initilzie():void 
		{
			craeteScenes();
			
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.NONE;
			
			
			
			
			// entry point
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
		private function craeteScenes():void 
		{
			
			stage.fullScreenSourceRect = new Rectangle(0, 0, 400, 400)
			
			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <flash.display.BitmapData>[new BitmapData(1, 1, true, 0x01000000)];
			Mouse.registerCursor('noCursor', cursor);
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			stage.quality = StageQuality.MEDIUM
			
		
			var stateManager:StatesManager = new StatesManager(this);

            var loadStateConfig:StateConfig = new StateConfig('Load', LoadGameController);
            var loadState:State = new State(loadStateConfig);

			var gameStateConfig:StateConfig = new StateConfig('Game', PlatformerTest);
			var gameState:State = new State(gameStateConfig);

			//stateManager.nextState(loadState);
			stateManager.nextState(gameState);

			stateManager.start();
			
			//addChild(new TheMiner());
			
		}
		
	}

}