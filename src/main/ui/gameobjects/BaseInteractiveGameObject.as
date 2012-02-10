package ui.gameobjects 
{
	import core.locators.ServicesLocator;
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
		
		override public function render():void 
		{
			super.render();
			
			if (body.y > 400)
			{
				destroy();
			}
			
			if (this.body.y > ServicesLocator.cameraService.camera.target.y + 500)
			{
				destroy();
			}
		}
		
		public function get interactiveObjectConfig():InteractiveObjectConfiguration 
		{
			return _interactiveObjectConfig;
		}
		
	}

}