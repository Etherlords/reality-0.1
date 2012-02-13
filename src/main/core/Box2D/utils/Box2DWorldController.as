package core.Box2D.utils 
{
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2World;
import Box2D.Dynamics.Controllers.b2Controller;
import core.Box2D.collision.SimpleConcatListener;
import core.Box2D.SimpleDestructionListenere;
import core.collections.SimpleMap;
import core.events.GameObjectPhysicEvent;
import core.events.NativeCollideEvent;
import core.GlobalConstants;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.GameObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;
import utils.DimensionalMath;



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
		private var _gameObjectsRegistry:GameobjectsRegistry;
		private var collideListener:SimpleConcatListener;
		
		private var _appliedControllersMap:SimpleMap;
		
		public function Box2DWorldController(gravity:Point, debugInstance:DisplayObjectContainer, isDebug:Boolean = false) 
		{
			this.isDebug = isDebug;
			this.debugInstance = debugInstance;
			this.gravity = gravity;
			
			initilize();
		}
		
		public function gameStep():void
		{
			for each (var preRenderObj:GameObject in _gameObjectsRegistry.objectsList) {
				
                preRenderObj.preRender(0.025 * 1000); //todo calc correctly
            }
			
			world.Step(0.04, 10, 10);
			world.ClearForces();
			
			if(isDebug)
				world.DrawDebugData();

            for each (var renderObj:GameObject in _gameObjectsRegistry.objectsList) {
                renderObj.render();
            }
        }
		
		public function get world():b2World 
		{
			return _world;
		}
		
		public function get gameObjectsRegistry():GameobjectsRegistry 
		{
			return _gameObjectsRegistry;
		}
		
		public function get appliedControllersMap():SimpleMap 
		{
			return _appliedControllersMap;
		}
		
		public function addToCollaboration(gameObject:GameObject):void
		{
			_gameObjectsRegistry.registerGameObject(gameObject);
			gameObject.addEventListener(GameObjectPhysicEvent.DESTROY, onGameObjectDestroyed);
		}
		
		public function getGameObjectsInRadius(applicationPoint:Point, radius:Number, filter:*):Vector.<GameObject>
		{
			var list:Vector.<GameObject> = new Vector.<GameObject>
			
			var object:GameObject;
			for each(object in _gameObjectsRegistry.objectsList)
			{
				if(DimensionalMath.inRadius(radius, applicationPoint, object.body.position))
					list.push(object);
			}
			
			return list;
		}
		
		private function onGameObjectDestroyed(e:GameObjectPhysicEvent):void 
		{
			e.interactionWith.removeEventListener(GameObjectPhysicEvent.DESTROY, onGameObjectDestroyed);
			removeFromCollaboration(e.interactionWith);
		}
		
		public function removeFromCollaboration(gameObject:GameObject):void
		{
			_gameObjectsRegistry.unRegisterGameObject(gameObject);
		}
		
		public function constructGameObject(objectClass:Class, config:GameobjectConfig, displayInstance:DisplayObjectContainer):GameObject
		{
			var processedGameObject:GameObject = new objectClass(config, displayInstance);
			registerGameObject(processedGameObject);
			addToCollaboration(processedGameObject);
			
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
		
		public function registerGameObject(gameObject:GameObject):void
		{
			gameObject.registredInApplication();
		}
		
		public function getController(controllerName:String):b2Controller
		{
			return _appliedControllersMap.getItem(controllerName) as b2Controller;
		}
		
		public function addController(controller:b2Controller, controllerName:String ):void
		{
			controller = world.CreateController(controller);
			_appliedControllersMap.addItem(controllerName, controller);
			
		}
		
		private function initilize():void 
		{
			initWorld();
			
			_appliedControllersMap = new SimpleMap(); 
			_gameObjectsRegistry = new GameobjectsRegistry();
			
			if (isDebug)
				initDebugDraw();
		}
		
		private function initWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(gravity.x, gravity.y);
			_world = new b2World(gravity, true);
			
			//Для трекинга коллизий мы добавляем слушателя коллизий в физический мир
			collideListener = new SimpleConcatListener();
			
			//Ловим ивент о нативном столкновении
			collideListener.addEventListener(NativeCollideEvent.PHYSIC_BODY_COLLIDE, notifObjectsCollide);
			
			_world.SetContactListener(collideListener);
			_world.SetDestructionListener(new SimpleDestructionListenere());
		}
		
		/**
		 * Нативное столкновение 2х объектов
		 * тут благодаря pBody-to-gameObject маппингу я могу получить по боди гейм обжекты
		 * Я могу оповестить гейм обжекты о том что они столкнулись с таким то объектом,
		 * но полагаю что нам лучше резолвить столкновения при вызове preRender, render или 
		 * ввести еще postRender
		 * 
		 * Т.е не обрабатывать каждое столкновение в частности а обрабатывать лист столкновений
		 * 
		 * resolveCollision->objectA.collideList-process->doSomeActions
		 * Так же резолвить столкновения очевидно нужно на уровне контейнера т.к логика взаимодействия объектов описана в нем
		 * 
		 * есть враинт такого флоу
		 * box2dWorld->nativeCollideEvent-to-GameObject->GameObject.notifiCollide(gameObject)->sendCollideEventToStage-resolve-collides;
		 * 
		 * но тут помойму куча лишних действий хотя и легко будет работать с такой моделью потому что все рбаотает не зависимо
		 * но обработка колайдов в одном месте скопом была бы явно производительней
		 * @param	e
		 */
		private function notifObjectsCollide(e:NativeCollideEvent):void 
		{
			var gameObjectA:GameObject = _gameObjectsRegistry.getGameObjectBy_b2body(e.bodyA);
			var gameObjectB:GameObject = _gameObjectsRegistry.getGameObjectBy_b2body(e.bodyB);
			
			/**
			 * Будем считать что если один из объектов отсутствует в мапе то
			 * столкновение былоо с левыми объектами не игровыми
			 * и его не нужно отслеживать.
			 */
			if (!gameObjectA || !gameObjectB)
				return
			
			gameObjectA.collideWith(gameObjectB)
			gameObjectB.collideWith(gameObjectA)
			
			//gameObjectA notify collide
			//gameObjectB notifi collide
		}

		private function initDebugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();

			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GlobalConstants.METRS_TO_PIXEL);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_aabbBit | b2DebugDraw.e_centerOfMassBit | b2DebugDraw.e_controllerBit | b2DebugDraw.e_pairBit);
			debugDraw.SetLineThickness(1);
			debugDraw.SetFillAlpha(0.3);
			world.SetDebugDraw(debugDraw);
			
			debugInstance.addChild(debugSprite);
			
		
		}
		
		
		
	}

}