package ui.gameobjects 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.camera.Camera;
	import core.view.gameobject.config.GameobjectConfig;
	import flash.display.DisplayObjectContainer;
	import ui.gameobjects.datavalues.InteractiveObjectConfiguration;
	/**
	 * ...
	 * @author 
	 */
	public class InteractiveGameObjectBuilder 
	{
		protected var interactiveObjectConfig:InteractiveObjectConfiguration;
		protected var gameobjectConfiguration:GameobjectConfig;
		protected var viewInstance:DisplayObjectContainer;
		protected var displayWidth:Number;
		protected var worldController:Box2DWorldController;
		
		protected var skinClass:Class;
		
		public function InteractiveGameObjectBuilder(viewInstance:DisplayObjectContainer, displayWidth:Number, worldController:Box2DWorldController) 
		{
			this.worldController = worldController;
			this.displayWidth = displayWidth;
			this.viewInstance = viewInstance;
			
			initilize();
		}
		
		protected function initilize():void 
		{
			
		}
		
		//environment
		protected function internalMake():BaseInteractiveGameObject
		{
			var interactiveGameObject:BaseInteractiveGameObject = craeteGameObject();
			
			preInitilizeObjectSettings(interactiveGameObject);
			registerGameObject(interactiveGameObject);
			
			return interactiveGameObject;
		}
		
		protected function preInitilizeObjectSettings(interactiveGameObject:BaseInteractiveGameObject):void
		{
			
		}
		
		protected function registerGameObject(interactiveGameObject:BaseInteractiveGameObject):void
		{
			worldController.registerGameObject(interactiveGameObject);
			worldController.addToCollaboration(interactiveGameObject);
		}
		
		protected function craeteGameObject():BaseInteractiveGameObject
		{
			return new BaseInteractiveGameObject(gameobjectConfiguration, interactiveObjectConfig, viewInstance);
		}
		
	}

}