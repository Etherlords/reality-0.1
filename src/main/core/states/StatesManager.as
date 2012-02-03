package core.states 
{
	import core.collections.SimpleMap;
	import core.states.events.StateEvents;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author 
	 */
	public class StatesManager 
	{
		
		private var activeState:State;
		
		private var states:Vector.<State>
		private var statesMap:SimpleMap;
		private var instance:DisplayObjectContainer;
		
		private var currentStateIndex:int = 0;
		
		public function StatesManager(instance:DisplayObjectContainer) 
		{
			this.instance = instance;
			initilize();
		}
		
		public function start():void
		{
			activateStateByIndex(currentStateIndex);
		}
		
		private function activateStateByIndex(index:int):void
		{
			activateState(states[index]);
		}
		
		private function activateState(state:State):void
		{
			
			if (activeState)
				deactivateState(activeState);
			
			state.stateInPoin(instance);
			activeState = state;
		}
		
		private function deactivateState(state:State):void 
		{
			state.stateOutPoint();
		}
		
		private function initilize():void 
		{
			states = new Vector.<State>;
			statesMap = new SimpleMap();
		}
		
		public function pushState(state:State):void
		{
			states.push(state);
			statesMap.addItem(state.id, state);
			
			state.addEventListener(StateEvents.STATE_OUT, nextState);
		}
		
		private function nextState(e:StateEvents):void 
		{
			
			currentStateIndex++;
			activateStateByIndex(currentStateIndex);
		}
		
		public function getStateByKey(key:String):State 
		{
			return statesMap.getItem(key) as State;
		}
		
	}

}