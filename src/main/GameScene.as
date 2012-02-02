package  
{
	import core.Box2D.utils.Box2DWorldConstructor;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
    import core.view.skin.EmptyBoxSkin;

    import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import patterns.strategy.Strategy;
	import patterns.strategy.StrategyController;
	import ui.Bell;
	import ui.rabbit.Rabbit;
	import ui.rabbit.RabbitSkin;
	import ui.rabbit.rabbitReactions.RabbitStandarJump;
	import utils.BoundariesConstructor;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScene extends Sprite 
	{
		private var worldConstructor:Box2DWorldConstructor;
		private var gameObject:Rabbit;
		private var rabbitReactions:StrategyController;
		private var bell:Bell;

        private var gameObjects:Array;

		public function GameScene() 
		{
			super();
			
			initilize();
		}
		
		private function initilize():void 
		{
            gameObjects = [];
			createWorld();
			createViewComponents();
			manageEvents();
			
			var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
			
			var updateRabbitMoveTimer:Timer = new Timer(100);
			updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, calculateObjectMoving);
			updateRabbitMoveTimer.start();
		}
		
		private function calculateObjectMoving(e:* = null):void 
		{
			var mouseX:Number = stage.mouseX;
			
			var rabbitX:Number =  gameObject.body.x;
			
			var delta:Number = mouseX - rabbitX;
			
			var force:Number = delta / 20;
			
			gameObject.applyMove(force);

		}
		
		private function manageEvents():void 
		{
			stage.addEventListener(MouseEvent.CLICK, jumpAction);
		}
		
		private function jumpAction(e:MouseEvent):void 
		{
			rabbitAction('standartJump', 10);
		}
		
		private function rabbitAction(key:String, ...rest):void
		{
			rest.unshift(gameObject);
			
			rabbitReactions.execute(key, rest);
		}
		
		private function createWorld():void 
		{
			worldConstructor = new Box2DWorldConstructor(new Point(0, 10), this, true);
			//trace(PhysicWorldLocator.instance);
			PhysicWorldLocator.instance.world = worldConstructor.world;
		}
		
		private function createViewComponents():void
		{
			
			rabbitReactions = new StrategyController();
			var standarJump:Strategy = new Strategy('standartJump', new RabbitStandarJump());
			rabbitReactions.addStrategy(standarJump);
			
			
			var defaultConfig:GameobjectConfig = new GameobjectConfig(true);
			defaultConfig.physicConfiguration.type = 2;
			defaultConfig.skinClass = EmptyBoxSkin;
			
			//Проблема что все объекты должны получать рендер/пререндер поэтому их нужно как тозаносить в обищй пулл
			//Пока хз как это лучше сделать.
			//Думаю можно сделать фабрику для создания конкретно сконфигурированых объектов factory.make(rabbit), factory.make(denisok)
			//и эта фектори уже будет так же работать с пулом
            var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
            rabbitConfig.physicConfiguration.type = 2;
            rabbitConfig.skinClass = RabbitSkin;
			gameObject = new Rabbit(rabbitConfig, this);
			
			bell = new Bell(defaultConfig, this);

            registerGameObject(gameObject);
            registerGameObject(bell);
			
			var boundaries:BoundariesConstructor = new BoundariesConstructor();
			boundaries.createBoundaries();
		}

        private function registerGameObject(gameObj:GameObject):void {
            gameObjects.push(gameObj);
        }
		
		/**
		 * Игровая итерация. Тут гейм обжекты должны получить пре рендер чтобы зкаомитить
		 * парамтеры в физический движок и рендер чтобы вызвать применение парамтеров физической модели к
		 * графике
		 * @param	e
		 */
		private function gameStep(e:* = null ):void
		{
            for each (var gameObj:GameObject in gameObjects) {
                gameObj.preRender();
            }
			
			worldConstructor.gameStep();

            for each (var gameObj:GameObject in gameObjects) {
                gameObj.render();
            }
		}
		
	}

}