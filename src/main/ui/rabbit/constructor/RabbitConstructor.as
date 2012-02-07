package ui.rabbit.constructor 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import ui.rabbit.Rabbit;
	import ui.rabbit.RabbitSkin;
	
	/**
	 * ...
	 * @author 
	 */
	public class RabbitConstructor
	{
		
		public function RabbitConstructor() 
		{
			
		}
		
		public static function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject
		{
			var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
			rabbitConfig.physicConfiguration.type = 2; //todo replace
			rabbitConfig.skinClass = RabbitSkin;
			var gameObject:GameObject = worldController.constructGameObject(Rabbit, rabbitConfig, stage);

			gameObject.body.x = 500;
			gameObject.body.y = 500;
			
			return gameObject;

		}
		
	}

}