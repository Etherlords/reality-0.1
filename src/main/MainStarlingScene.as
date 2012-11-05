package  
{
	import core.states.config.StateConfig;
	import core.states.State;
	import core.states.StatesManager;
	import pingPong.PingPong;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
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
			
			
			
			stateManager.nextState(gameState);
			
			stateManager.start();
		}
		
	}

}