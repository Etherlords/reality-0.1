package ui.gameobjects.bell 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.EmptyBoxSkin;
	import features.gameactions.SimpleInteractiveObjectCreationAction;
	import features.gameactions.SimpleInteractiveObjectDestroyAction;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;

	import ui.gameobjects.BaseInteractiveGameObject;
	import ui.gameobjects.datavalues.InteractiveObjectConfiguration;
	import ui.gameobjects.InteractiveGameObjectBuilder;
	import ui.gameobjects.linearMovingObject.LinearMovingInteractiveObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class BirdBuilder extends InteractiveGameObjectBuilder 
	{
		private var lastCreatedObject:BaseInteractiveGameObject;
		
		public function BirdBuilder(viewInstance:DisplayObjectContainer, displayWidth:Number, worldController:Box2DWorldController) 
		{
			super(viewInstance, displayWidth, worldController);
			
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
			this.lastCreatedObject = lastCreatedObject;
			
			return internalMake();
		}
		
		override protected function craeteGameObject():BaseInteractiveGameObject 
		{
			return new LinearMovingInteractiveObject(gameobjectConfiguration, interactiveObjectConfig, viewInstance);
		}
		
		override protected function preInitilizeObjectSettings(interactiveGameObject:BaseInteractiveGameObject):void 
		{
			super.preInitilizeObjectSettings(interactiveGameObject);
			
			interactiveGameObject.body.x = Math.random() * displayWidth;
			
			if (lastCreatedObject)
				if(!lastCreatedObject.markToDestroy)
					interactiveGameObject.body.y = lastCreatedObject.body.y - 100;
				else
					interactiveGameObject.body.y = 300
			else
				interactiveGameObject.body.y = 300
					
			
		}
		
	}

}