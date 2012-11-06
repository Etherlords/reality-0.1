package  
{
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class BlowEffect extends TailController 
	{
		
		public function BlowEffect() 
		{
			super();
			
		}
		
		override protected function onInit(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function reset():void
		{
			emitterType = 1;
			emitAngle = 0;	emitAngleVariance = 0;
			maxRadius = 20;	maxRadiusVariance = 0;
			minRadius = 20;
			rotatePerSecond = 360 * 36
			x = 0;
			y = 0;
			emitterXVariance = 0;
			emitterYVariance = 0;
			emitterX = 0;
			emitterY = 0;
			emitAngleVariance = 0;
			gravityX = 0;
			gravityY = 0
			
			
			maxNumParticles = 25
			
			startSize = 10;
			endSize = 10;
			
			startSizeVariance = 25;
			endSizeVariance = 15;
			
			lifespan = 0.05;
			lifespanVariance = 0;
			
			startColor.red = 0.7;
			startColor.blue = 1;
			startColor.green = 1;
			
			endColor.red = 0.7;
			endColor.blue = 1;
			endColor.green = 1;
			
			startColor.alpha = 1;
			endColor.alpha = 1;
		}
		
	}

}