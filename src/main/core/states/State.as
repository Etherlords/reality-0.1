package core.states 
{
	import core.scene.AbstractSceneController;
	import core.states.config.StateConfig;
	import core.states.events.StateEvents;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	
	 
	/**
	 * 
	 * @eventType	core.states.events.StateEvents.STATE_OUT
	 */
	[Event(name = "out-state", type = "core.states.events.StateEvents")] 
	
	/**
	 * 
	 * @eventType	core.states.events.StateEvents.STATE_ENTRY
	 */
	[Event(name = "out-state", type = "core.states.events.StateEvents")] 
	
	/**
	 * 
	 * @eventType	core.states.events.StateEvents.STATE_INITILIZED
	 */
	[Event(name = "initilized-state", type = "core.states.events.StateEvents")] 
	 
	public class State extends EventDispatcher
	{
		private var sceneController:AbstractSceneController;
		
		private var isActive:Boolean = false;
		
		private var config:StateConfig;
		
		public function State(config:StateConfig) 
		{
			this.config = config;
			initilize();
		}
		
		/**
		 * Айди стейта нужны для мапинга сцен
		 */
		public function get id():String
		{
			return config.stateId;
		}
		
		private function initilize():void
		{
			sceneController = new config.controllerClass();
			sceneController.addEventListener(StateEvents.STATE_OUT, outState);
		}
		
		private function outState(e:StateEvents):void 
		{
			dispatchEvent(new StateEvents(StateEvents.STATE_OUT));
		}
		
		/**
		 * Сообщяем стейту что он стал не активным
		 */
		public function stateOutPoint():void
		{
			isActive = false;
			sceneController.deactivate();
		}
		
		/**
		 * Сообщаем стейту что он стал активным
		 * и передаем инстанс для UI
		 * @param	instance Инстанс нужен чтобы знать куда воткнуть UI
		 */
		public function stateInPoin(instance:DisplayObjectContainer):void
		{
			if (isActive)
				throw new Error("State alredy active");
			
			isActive = true;
			sceneController.activate(instance);
		}
		
	}

}