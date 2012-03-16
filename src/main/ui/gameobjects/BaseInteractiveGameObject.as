package ui.gameobjects 
{
	import core.GlobalConstants;
	import core.locators.ServicesLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
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
		
		public function BaseInteractiveGameObject(config:GameobjectConfig, interactiveObjectConfig:InteractiveObjectConfiguration, phyciModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher=null) 
		{
			super(config, phyciModel, instance, eventFlowTarget);	
			
			_interactiveObjectConfig = interactiveObjectConfig;
			
		}
		
		override public function destroy():void 
		{
			skin.doAction( GlobalConstants.ACTION_DESTROY);
			super.destroy();
		}
		
		override public function render():void 
		{
			super.render();
			
			if (body.y > 600)
			{
				super.destroy();
			}
			
			if (this.body.y > ServicesLocator.cameraService.camera.target.y + 700)
			{
				super.destroy();
			}
		}
		
		public function get interactiveObjectConfig():InteractiveObjectConfiguration 
		{
			return _interactiveObjectConfig;
		}
		
	}

}