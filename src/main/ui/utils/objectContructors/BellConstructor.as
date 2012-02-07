package ui.utils.objectContructors 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.camera.Camera;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.skin.EmptyBoxSkin;
	import flash.display.DisplayObjectContainer;
	import ui.Bell;
	/**
	 * ...
	 * @author 
	 */
	public class BellConstructor 
	{
		
		public function BellConstructor() 
		{
			
		}
		
		public static function make(camera:Camera, lastBell:Bell, stage:DisplayObjectContainer, maxWidth:Number, worldController:Box2DWorldController):GameObject
		{
			var bellConfig:GameobjectConfig = new GameobjectConfig(true);
			bellConfig.physicConfiguration.type = 2; //todo replace
			bellConfig.skinClass = EmptyBoxSkin;
			var bell:Bell = new Bell(bellConfig, stage)//worldConstructor.constructGameObject(Bell, bellConfig, this) as Bell;// new Bell(bellConfig, this);

			bell.body.x = Math.random() * maxWidth;
			
			if (lastBell)
				if(!lastBell.markToDestroy)
					bell.body.y = lastBell.body.y - 200;
				else
					bell.body.y = camera.target.y - stage.stage.stageHeight / 2;
			else
				bell.body.y = camera.target.y - stage.stage.stageHeight / 2;

			worldController.registerGameObject(bell);
			worldController.addToCollaboration(bell);
			
			return bell;

		}
		
	}

}