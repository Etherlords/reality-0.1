package  
{
	import core.Box2D.utils.Box2DWorldConstructor;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScene extends Sprite 
	{
		private var worldConstructor:Box2DWorldConstructor;
		private var gameObject:GameObject;

		public function GameScene() 
		{
			super();
			
			initilize();
		}
		
		private function initilize():void 
		{
			createWorld();
			createViewComponents();
			
			var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
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
			
			//Проблема что все объекты должны получать рендер/пререндер поэтому их нужно как тозаносить в обищй пулл
			//Пока хз как это лучше сделать.
			//Думаю можно сделать фабрику для создания конкретно сконфигурированых объектов factory.make(rabbit), factory.make(denisok)
			//и эта фектори уже будет так же работать с пулом
			gameObject = new GameObject(config, this);
			//createBoundaries();
		
			
		}
		
		/**
		 * Игровая итерация. Тут гейм обжекты должны получить пре рендер чтобы зкаомитить
		 * парамтеры в физический движок и рендер чтобы вызвать применение парамтеров физической модели к
		 * графике
		 * @param	e
		 */
		private function gameStep(e:* = null ):void
		{
			gameObject.preRender();
			
			worldConstructor.world.Step(0.04, 100, 100);
			worldConstructor.world.DrawDebugData();
			
			gameObject.render();
		}
		
	}

}