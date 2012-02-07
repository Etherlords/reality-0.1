package ui 
{
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class Bell extends GameObject 
	{
		
		
		public function Bell(config:GameobjectConfig, instance:DisplayObjectContainer) 
		{
			super(config, instance);
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			//physicalProperties
			// :C~~~~~
			(physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetSensor(true);
			//isSensor = true;
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		override public function render():void 
		{
			flowerEffect();
			super.render();
			
			
		}
		
		/**
		 * Эфект парения, линейное ускорение по Y гасится и объект как бы падает плавно
		 */
		private function flowerEffect():void 
		{
			//this.applyImpulseFromCenter(new b2Vec2(0, -1));
			var linearVelocity:Point = physicalProperties.linearVelocity
			linearVelocity.y = 0.1;
			
			physicalProperties.linearVelocity = linearVelocity;
		}
		
	}

}