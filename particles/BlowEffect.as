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
			emitterType = 1;
			emitAngle = 0;	emitAngleVariance = Math.PI;
			maxRadius = 10;	maxRadiusVariance = 0;
			minRadius = 10;
			
			maxNumParticles = 150;
			
			startSize = 10;
			endSize = 7;
			startSizeVariance = 0;
			endSizeVariance = 0;
			
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