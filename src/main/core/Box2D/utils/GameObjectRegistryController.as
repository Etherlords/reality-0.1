package core.Box2D.utils 
{
	import core.events.GameObjectPhysicEvent;
	import core.view.gameobject.GameObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class GameObjectRegistryController 
	{
		private var _gameObjectsRegistry:GameobjectsRegistry;
		
		private var getObjectsInRadiusAlgorithm:GetGameobjectsInRadius;
		
		public function GameObjectRegistryController() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			
			_gameObjectsRegistry = new GameobjectsRegistry();
			
			getObjectsInRadiusAlgorithm = new GetGameobjectsInRadius(_gameObjectsRegistry);
		}
		
		/**
		 * TODO: на будущее нужно будет привести работу подобных утилит для какого то запроса к обжект ригистри в какую то систему
		 * чтобы можно было легко добавлять и работать с алгоритмами запросов
		 * 
		 * Типа дай мне объекты в радиусе отностилеьно точки
		 * Дай мне все динамические объекты
		 * 
		 * Диай мне все объекты помеченые на уничтожение
		 * 
		 * Дай мне все объекты которые имеют столкновения и тд
		 * 
		 * хотя по сути возможно это все можно свести к array.filter(filterFunction);
		 */
		public function getObjectsInRadius(applicationPoint:Point, radius:Number, filterFunction:*):void
		{
			getObjectsInRadiusAlgorithm.execute(applicationPoint, radius, filterFunction);
		}
		
		public function get gameObjectsRegistry():GameobjectsRegistry 
		{
			return _gameObjectsRegistry;
		}
		
		public function addToCollaboration(gameObject:GameObject):void
		{
			_gameObjectsRegistry.registerGameObject(gameObject);
			gameObject.addEventListener(GameObjectPhysicEvent.DESTROY, onGameObjectDestroyed);
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
		
		public function registerGameObject(gameObject:GameObject):void
		{
			gameObject.registredInApplication();
		}
	}

}