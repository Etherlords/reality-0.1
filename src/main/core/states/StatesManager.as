package core.states 
{
	import core.collections.SimpleMap;
	import core.states.events.StateEvents;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author 
	 */
	public class StatesManager 
	{
		/**
		 * TODO: 
			 * нужна вещь как логика выхода или входа на сцену, очередность сцен и связывание сцен
			 * т.е
			 * 
			 * У сцены должно быть условия входа ее появления,
			 * У сцены должно бьть условия выхода(перехода к следующей сцене)
			 * У сцены должна быть возможность задать следующую сцену или список сцен, или далее они просто идут по порядку
		 */
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
		
		public function nextState(state:State):void
		{
			states.push(state);
			statesMap.addItem(state.id, state);
			
			state.addEventListener(StateEvents.STATE_OUT, stateOutHandler);
		}
		
		private function stateOutHandler(e:StateEvents):void
		{
			currentStateIndex++;
			
			if (currentStateIndex > states.length - 1)
				currentStateIndex = states.length - 1;
			
			activateStateByIndex(currentStateIndex);
		}
		
		public function getStateByKey(key:String):State 
		{
			return statesMap.getItem(key) as State;
		}
		
	}

}