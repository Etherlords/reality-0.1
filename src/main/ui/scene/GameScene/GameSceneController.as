package ui.scene.GameScene 
{
	import core.scene.AbstractSceneController;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameSceneController extends AbstractSceneController 
	{
		
		public function GameSceneController() 
		{
			super();
			
		}
		
		public function activate(instance:DisplayObjectContainer):void
		{		
			setViewComponent(new GameScene);
			super.activate();
		}
		
	}

}