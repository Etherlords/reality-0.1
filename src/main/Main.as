package  
{
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import pingPong.PingPong;
	import ui.scene.gameInteractionScene.LoadGameController;



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
			TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);

			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <flash.display.BitmapData>[new BitmapData(1, 1, true, 0x01000000)];
			Mouse.registerCursor('noCursor', cursor);
			
			
			//stage.align = 'TL';
			//stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.quality = StageQuality.BEST
			
		
			var stateManager:StatesManager = new StatesManager(this);

            var loadStateConfig:StateConfig = new StateConfig('Load', LoadGameController);
            var loadState:State = new State(loadStateConfig);

			var gameStateConfig:StateConfig = new StateConfig('Game', PingPong);
			var gameState:State = new State(gameStateConfig);

			//stateManager.nextState(loadState);
			stateManager.nextState(gameState);

			stateManager.start();
			
			//addChild(new TheMiner());
			
		}
		
	}

}