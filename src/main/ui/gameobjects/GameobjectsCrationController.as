package ui.gameobjects 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.camera.Camera;
	import flash.display.DisplayObjectContainer;
	import ui.gameobjects.bell.BellBuilder;
	import ui.gameobjects.bell.BirdBuilder;
	/**
	 * ...
	 * @author 
	 */
	public class GameobjectsCrationController 
	{
		private var viewInstance:DisplayObjectContainer;
		private var displayWidth:Number;
		private var worldController:Box2DWorldController;
		
		private var bellBuilder:BellBuilder;
		private var birdBuilder:BirdBuilder;
		
		private var bellsBuilded:Number = 0;
		
		public function GameobjectsCrationController(viewInstance:DisplayObjectContainer, displayWidth:Number, worldController:Box2DWorldController) 
		{
			this.worldController = worldController;
			this.displayWidth = displayWidth;
			this.viewInstance = viewInstance;
			
			initilize();
		}
		
		private function initilize():void 
		{
			bellBuilder = new BellBuilder(viewInstance, displayWidth, worldController);
			birdBuilder = new BirdBuilder(viewInstance, displayWidth, worldController);
		}
		
		public function createGameobjectOvertimeTrigger(lastCrationObject:BaseInteractiveGameObject):BaseInteractiveGameObject
		{
			
			if (bellsBuilded < 4)
			{
				bellsBuilded++;
				return bellBuilder.make(lastCrationObject);
			}
			else
			{
				bellsBuilded = 0;
				return birdBuilder.make(lastCrationObject);
			}
		}
		
	}

}