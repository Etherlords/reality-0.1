package  
{
	import com.sociodox.theminer.TheMiner;
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import ui.scene.gameInteractionScene.HighDelivery;
	import ui.scene.gameInteractionScene.LoadGameController;
	import ui.scene.gameInteractionScene.PlatformerTest;
	import ui.scene.gameInteractionScene.GameSceneController;


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
			
		}
		
		private function craeteScenes():void 
		{
			
			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <flash.display.BitmapData>[new BitmapData(1, 1, true, 0x01000000)];
			Mouse.registerCursor('noCursor', cursor);
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
		
			var stateManager:StatesManager = new StatesManager(this);

            var loadStateConfig:StateConfig = new StateConfig('Load', LoadGameController);
            var loadState:State = new State(loadStateConfig);

			var gameStateConfig:StateConfig = new StateConfig('Game', PlatformerTest);
			var gameState:State = new State(gameStateConfig);

			stateManager.nextState(loadState);
			stateManager.nextState(gameState);

			stateManager.start();
			
			addChild(new TheMiner());
			
		}
		
	}

}