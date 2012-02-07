package  
{
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display.Sprite;
	import ui.scene.gameInteractionScene.GameSceneController;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class MainEntry extends Sprite 
	{
		
		public function MainEntry() 
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
			
			var gameStateConfig:StateConfig = new StateConfig('Game', GameSceneController);
			var gameState:State = new State(gameStateConfig);
			
			stateManager.pushState(gameState);
			
			stateManager.start();
			
		}
		
	}

}