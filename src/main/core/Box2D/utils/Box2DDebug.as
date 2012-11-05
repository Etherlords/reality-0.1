package core.Box2D.utils 
{
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import core.GlobalConstants;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Box2DDebug 
	{
		private var viewInstance:DisplayObjectContainer;
		private var debugDraw:b2DebugDraw;
		private var world:b2World;
		private var debugSprite:Sprite;
		
		public function Box2DDebug(viewInstance:DisplayObjectContainer, world:b2World) 
		{
			this.world = world;
			this.viewInstance = viewInstance;
			initDebugDraw();
		}
		
		public function render():void
		{
			world.DrawDebugData();
			
			//debugSprite.graphics.beginFill(0xFFFFFF);
			//debugSprite.graphics.drawRect(0, 0, 400, 400);
		}
		
		private function initDebugDraw():void
		{
			debugDraw = new b2DebugDraw();
			debugSprite = new Sprite();

			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GlobalConstants.METRS_TO_PIXEL);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_aabbBit | b2DebugDraw.e_centerOfMassBit | b2DebugDraw.e_controllerBit | b2DebugDraw.e_pairBit | b2DebugDraw.e_jointBit);
			
			debugDraw.SetLineThickness(1);
			debugDraw.SetFillAlpha(0.3);
			world.SetDebugDraw(debugDraw);
			
			viewInstance.addChild(debugSprite);
			
			
			
		
		}
	}

}