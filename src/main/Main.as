package  
{
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display.Sprite;
	import ui.scene.gameInteractionScene.GameSceneController;
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
		}
		
		private function craeteScenes():void 
		{
			var stateManager:StatesManager = new StatesManager(this);

            var loadStateConfig:StateConfig = new StateConfig('Load', LoadGameController);
            var loadState:State = new State(loadStateConfig);

			var gameStateConfig:StateConfig = new StateConfig('Game', GameSceneController);
			var gameState:State = new State(gameStateConfig);


			
			stateManager.pushState(loadState);
			stateManager.pushState(gameState);

			stateManager.start();
			
		}
		
	}

}