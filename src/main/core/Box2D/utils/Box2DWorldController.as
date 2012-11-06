package core.Box2D.utils 
{
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2World;
import Box2D.Dynamics.Controllers.b2Controller;
import core.Box2D.collision.SimpleConcatListener;
import core.Box2D.SimpleDestructionListenere;
import core.collections.SimpleMap;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.GameObject;
import core.view.gameobject.physicalpropeties.PhysicModel;
import flash.geom.Point;
import starling.display.DisplayObjectContainer;
import utils.GlobalUIContext;



/**
	 * Класс для создания и работы с физическим миром
	 * Будем считать что в одно время у нас существует один мир
	 * Покрайнемере в рамках этой игры больше не понадобится
	 * @author 
	 */
	public class Box2DWorldController 
	{
		private var gravity:Point;
		private var debugInstance:DisplayObjectContainer;
		private var isDebug:Boolean;
		
		private var _world:b2World;
		
		private var collideListener:SimpleConcatListener;
		
		private var _appliedControllersMap:SimpleMap;
		private var debugDraw:Box2DDebug;
		
		private var _gameObjectRegistryController:GameObjectRegistryController;
		private var _gameObjectsRegistry:GameobjectsRegistry;
		
		public function Box2DWorldController(gravity:Point, debugInstance:DisplayObjectContainer = null, isDebug:Boolean = false) 
		{
			this.isDebug = isDebug;
			this.debugInstance = debugInstance;
			this.gravity = gravity;
			
			initilize();
		}
		
		public function get world():b2World 
		{
			return _world;
		}

		public function get appliedControllersMap():SimpleMap 
		{
			return _appliedControllersMap;
		}
		
		public function get gameObjectRegistryController():GameObjectRegistryController 
		{
			return _gameObjectRegistryController;
		}
		
		private function initilize():void 
		{
			
			//сдесь описывается _gameObjectsRegistry чтобы не нужно было вызывать его через . а просто хранится ссылка на нужный объект для внутреннего использования
			_gameObjectRegistryController = new GameObjectRegistryController();
			_gameObjectsRegistry = _gameObjectRegistryController.gameObjectsRegistry;
			
			initWorld();
			
			_appliedControllersMap = new SimpleMap(); 
			
			if (isDebug)
				debugDraw = new Box2DDebug(GlobalUIContext.debugContainer, world);
		}
		
		private function initWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(gravity.x, gravity.y);
			_world = new b2World(gravity, true);
			
			//Для трекинга коллизий мы добавляем слушателя коллизий в физический мир
			collideListener = new SimpleConcatListener(_gameObjectRegistryController.gameObjectsRegistry);
			
			//Ловим ивент о нативном столкновении
			//UPDATE: Больше тут не слушаем ивент а просто внутри объекта делаем нужное оповещение
			//collideListener.addEventListener(NativeCollideEvent.PHYSIC_BODY_COLLIDE, notifObjectsCollide);
			
			_world.SetContactListener(collideListener);
			_world.SetDestructionListener(new SimpleDestructionListenere());
		}
		
		/**
		 * Вызывает следующий степ в физическом движке, а так же вызвает 
		 * preRender, render, drawDebugData
		 */
		public function gameStep():void
		{
			var interestObject:GameObject;
			for each (interestObject in _gameObjectsRegistry.objectsList) 
			{
                interestObject.preRender(0.025 * 1000); //todo calc correctly
            }
			
			world.Step(0.036, 1, 1);
			world.ClearForces();
			
			if(isDebug)
				debugDraw.render();

            for each (interestObject in _gameObjectsRegistry.objectsList) 
			{
                interestObject.render();
            }
        }
		
		/**
		 * Создает гейм обжект и регестрирует его в мире, добавляет в регистр и вызывает иницилизацию
		 * 
		 * @param	objectClass
		 * @param	config
		 * @param	physicModel
		 * @param	displayInstance
		 * @return
		 */
		public function constructGameObject(objectClass:Class, config:GameobjectConfig, physicModel:PhysicModel, displayInstance:DisplayObjectContainer):GameObject
		{
			var processedGameObject:GameObject = new objectClass(config, physicModel, displayInstance);
			_gameObjectRegistryController.registerGameObject(processedGameObject);
			_gameObjectRegistryController.addToCollaboration(processedGameObject);
			
			return processedGameObject;
		}
		
		/**
		 * Уничтожаем гейм обжект, объект убирается из дисплей листа и уничтожается в физическом мире
		 * Объект уничтожается потому что его нельзя реюзать в физическом мире если мы его убираем из него
		 * @param	gameObject
		 */
		public function destroyGameObject(gameObject:GameObject):void
		{
			//removeFromCollaboration(gameObject);
			gameObject.destroy();
		}
		
		/**
		 * TODO: Наверное нужно будет рабоут с контроллерами патом вынести в отдельный класс
		 * @param	controllerName
		 * @return
		 */
		public function getController(controllerName:String):b2Controller
		{
			return _appliedControllersMap.getItem(controllerName) as b2Controller;
		}
		
		public function addController(controller:b2Controller, controllerName:String ):void
		{
			controller = world.CreateController(controller);
			_appliedControllersMap.addItem(controllerName, controller);	
		}
		
		
		
	}

}