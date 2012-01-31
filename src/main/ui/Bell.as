package ui 
{
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
	public class Bell extends GameObject 
	{
		private var t:Timer;
		
		public function Bell(config:GameobjectConfig, instance:Sprite) 
		{
			super(config, instance);
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			//isSensor = true;
			
		
		}
		
		override public function destroy():void 
		{
		
			
			super.destroy();
		}
		
		override public function preRender():void 
		{
			super.preRender();
			
			flowerEffect();
		}
		
		private function flowerEffect():void 
		{
			
			//this.applyImpulseFromCenter(new b2Vec2(0, -1));
			var linearVelocity:Point = physicalProperties.linearVelocity
			linearVelocity.y = 0.1;
			
			physicalProperties.linearVelocity = physicalProperties.linearVelocity;
			
			
			
		}
		
	}

}