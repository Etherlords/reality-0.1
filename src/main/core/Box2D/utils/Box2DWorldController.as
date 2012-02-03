package core.Box2D.utils 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import core.Box2D.collision.SimpleConcatListener;
	import core.events.NativeCollideEvent;
	import core.GlobalConstants;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * Класс для создания и работы с физическим миром
	 * Будем считать что в одно время у нас существует один мир
	 * Покрайнемере в рамках этой игры больше не понадобится
	 * @author 
	 */
	public class Box2DWorldController 
	{
		private var gravity:Point;
		private var debugInstance:Sprite;
		private var isDebug:Boolean;
		
		private var _world:b2World;
		private var _gameObjectsRegistry:GameobjectsRegistry;
		private var collideListener:SimpleConcatListener;
		
		public function Box2DWorldController(gravity:Point, debugInstance:Sprite, isDebug:Boolean = false) 
		{
			this.isDebug = isDebug;
			this.debugInstance = debugInstance;
			this.gravity = gravity;
			
			initilize();
		}
		
		public function gameStep():void
		{
			_gameObjectsRegistry.objectsList.forEach(preRenderCall);
			
			world.Step(0.04, 100, 100);
			
			if(isDebug)
				world.DrawDebugData();
				
			_gameObjectsRegistry.objectsList.forEach(renderCall);
		}
		
		private function renderCall(gameObject:GameObject, i:int, vector:Vector.<GameObject>):void 
		{
			gameObject.render();
		}
		
		private function preRenderCall(gameObject:GameObject, i:int, vector:Vector.<GameObject>):void 
		{
			gameObject.preRender();
		}
		
		public function get world():b2World 
		{
			return _world;
		}
		
		public function get gameObjectsRegistry():GameobjectsRegistry 
		{
			return _gameObjectsRegistry;
		}
		
		public function registerGameObject(gameObject:GameObject):void
		{
			_gameObjectsRegistry.registerGameObject(gameObject);
		}
		
		private function initilize():void 
		{
			initWorld();
			
			_gameObjectsRegistry = new GameobjectsRegistry();
			
			if (isDebug)
				initDebugDraw();
		}
		
		private function initWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(gravity.x, gravity.y);
			_world = new b2World(gravity, true);
			
			collideListener = new SimpleConcatListener();
			
			collideListener.addEventListener(NativeCollideEvent.PHYSIC_BODY_COLLIDE, notifObjectsCollide);
			
			_world.SetContactListener(collideListener);
		}
		
		private function notifObjectsCollide(e:NativeCollideEvent):void 
		{
			var gameObjectA:GameObject = _gameObjectsRegistry.getGameObjectBy_b2body(e.bodyA);
			var gameObjectB:GameObject = _gameObjectsRegistry.getGameObjectBy_b2body(e.bodyB);
			
			trace(gameObjectA, gameObjectB);
			
			//gameObjectA notify collide
			//gameObjectB notifi collide
		}
		
		private function initDebugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GlobalConstants.METRS_TO_PIXEL);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			
			world.SetDebugDraw(debugDraw);
			
			debugInstance.addChild(debugSprite);
		}
		
		
		
	}

}