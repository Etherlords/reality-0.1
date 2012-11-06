package  
{
	import core.locators.ServicesLocator;
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.TextureBase;
	import pingPong.logic.PingPong;
	import pingPong.settings.PingPongSettingsController;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.ConcreteTexture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class MainStarlingScene extends DisplayObjectContainer 
	{
		
		public function MainStarlingScene() 
		{
			super();
			
				
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			var stateManager:StatesManager = new StatesManager(this as DisplayObjectContainer);
			
			var gameStateConfig:StateConfig = new StateConfig('Game', PingPong);
			var gameState:State = new State(gameStateConfig);
			
			var settinsStateConfig:StateConfig = new StateConfig('Settings', PingPongSettingsController);
			var settingsState:State = new State(settinsStateConfig);
			
			if(StarlingInit.settings.isShowSettingsOnStart)
				stateManager.nextState(settingsState);
			
			stateManager.nextState(gameState);
			
			stateManager.start();
		}
		
		
		
	}

}