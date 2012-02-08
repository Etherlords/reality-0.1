package ui.gameobjects 
{
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import ui.gameobjects.datavalues.InteractiveObjectConfiguration;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseInteractiveGameObject extends GameObject 
	{
		private var _interactiveObjectConfig:InteractiveObjectConfiguration;
		
		public function BaseInteractiveGameObject(config:GameobjectConfig, interactiveObjectConfig:InteractiveObjectConfiguration, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher=null) 
		{
			super(config, instance, eventFlowTarget);	
			_interactiveObjectConfig = interactiveObjectConfig;
			
		}
		
		public function get interactiveObjectConfig():InteractiveObjectConfiguration 
		{
			return _interactiveObjectConfig;
		}
		
	}

}