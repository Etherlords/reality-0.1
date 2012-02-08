package ui.gameobjects.bell 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.camera.Camera;
	import core.locators.ServicesLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.EmptyBoxSkin;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import gameactions.SimpleInteractiveObjectCreationAction;
	import gameactions.SimpleInteractiveObjectDestroyAction;
	import ui.gameobjects.BaseInteractiveGameObject;
	import ui.gameobjects.datavalues.InteractiveObjectConfiguration;
	import ui.gameobjects.InteractiveGameObjectBuilder;
	import ui.gameobjects.simpleFlowObject.FlowInteractiveObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class BellBuilder extends InteractiveGameObjectBuilder 
	{
		private var lastCreatedObject:BaseInteractiveGameObject;
		private var camera:Camera;
		
		public function BellBuilder(viewInstance:DisplayObjectContainer, displayWidth:Number, worldController:Box2DWorldController) 
		{
			super(viewInstance, displayWidth, worldController);
			this.camera = ServicesLocator.cameraService.camera;
			
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			gameobjectConfiguration = new GameobjectConfig(true);
			gameobjectConfiguration.physicConfiguration.type = 2; //todo replace
			gameobjectConfiguration.skinClass = EmptyBoxSkin;
			
			
			interactiveObjectConfig = new InteractiveObjectConfiguration(getQualifiedClassName(this), new SimpleInteractiveObjectDestroyAction(), new SimpleInteractiveObjectCreationAction());
		}
		
		public function make(lastCreatedObject:BaseInteractiveGameObject):BaseInteractiveGameObject 
		{
			this.camera = camera;
			this.lastCreatedObject = lastCreatedObject;
			
			return internalMake();
		}
		
		override protected function craeteGameObject():BaseInteractiveGameObject 
		{
			return new FlowInteractiveObject(gameobjectConfiguration, interactiveObjectConfig, viewInstance);
		}
		
		override protected function preInitilizeObjectSettings(interactiveGameObject:BaseInteractiveGameObject):void 
		{
			super.preInitilizeObjectSettings(interactiveGameObject);
			
			interactiveGameObject.body.x = Math.random() * displayWidth;
			
			if (lastCreatedObject)
				if(!lastCreatedObject.markToDestroy)
					interactiveGameObject.body.y = lastCreatedObject.body.y - 100;
				else
					interactiveGameObject.body.y = camera.target.y - viewInstance.stage.stageHeight / 2;
			else
				interactiveGameObject.body.y = camera.target.y - viewInstance.stage.stageHeight / 2;
		}
		
	}

}