package  
{
	import core.Box2D.utils.Box2DWorldConstructor;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScene extends Sprite 
	{
		private var worldConstructor:Box2DWorldConstructor;

		public function GameScene() 
		{
			super();
			
			initilize();
		}
		
		private function initilize():void 
		{
			createWorld();
			createViewComponents();
		}
		
		private function createWorld():void 
		{
			worldConstructor = new Box2DWorldConstructor(new Point(0, 10), this, true);
			//trace(PhysicWorldLocator.instance);
			PhysicWorldLocator.instance.world = worldConstructor.world;
		}
		
		private function createViewComponents():void
		{
			
			var config:GameobjectConfig = new GameobjectConfig(true);
			config.physicConfiguration.type = 2;
			
			var gameObject:GameObject = new GameObject(config);
			//createBoundaries();
			
			worldConstructor.world.Step(0.04, 100, 100);
			worldConstructor.world.DrawDebugData();
		}
		
	}

}