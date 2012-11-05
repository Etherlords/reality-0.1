package  
{
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class BigBlowEffect extends TailController 
	{
		
		public function BigBlowEffect() 
		{
			super();
			
		}
		
		override protected function onInit(e:Event):void 
		{
			emitterType = 1;
			emitAngle = 0;	emitAngleVariance = Math.PI;
			maxRadius = 15;	maxRadiusVariance = 0;
			minRadius = 5;
			
			maxNumParticles = 1000;
			rotatePerSecond = 1;
			startSize = 25;
			endSize = 70;
			startSizeVariance = 40;
			endSizeVariance = 50;
			
			lifespan = 0.1;
			lifespanVariance = 0.1;
			
			startColor.red = 1;
			startColor.blue = 1;
			startColor.green = 1;
			
			startColor.red = 0.6;
			startColor.blue = 1;
			startColor.green = 1;
			
			startColor.alpha = 0.8;
			endColor.alpha = 0;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			Starling.juggler.add(this);
		}
		
	}

}