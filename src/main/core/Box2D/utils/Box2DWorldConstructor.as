package core.Box2D.utils 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import core.GlobalConstants;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * Класс для создания и работы с физическим миром
	 * Будем считать что в одно время у нас существует один мир
	 * Покрайнемере в рамках этой игры больше не понадобится
	 * @author 
	 */
	public class Box2DWorldConstructor 
	{
		private var gravity:Point;
		private var debugInstance:Sprite;
		private var isDebug:Boolean;
		
		private var _world:b2World;
		
		public function Box2DWorldConstructor(gravity:Point, debugInstance:Sprite, isDebug:Boolean = false) 
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
		
		private function initilize():void 
		{
			initWorld();
			
			if (isDebug)
				initDebugDraw();
		}
		
		private function initWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(gravity.x, gravity.y);
			_world = new b2World(gravity, true);
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