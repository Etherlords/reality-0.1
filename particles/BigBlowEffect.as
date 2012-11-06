package  
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class BigBlowEffect extends TailController 
	{
		private var t:Tween;
		
		public function BigBlowEffect() 
		{
			super();
			
		}
		
		override protected function onInit(e:Event):void 
		{
			emitterType = 1;
			emitAngle = 0;	emitAngleVariance = Math.PI;
			maxRadius = 1;	maxRadiusVariance = 0;
			minRadius = 1;
			
			maxNumParticles = 2000;
			rotatePerSecond = 1;
			
			startSize = 10;
			startSizeVariance = 20;
			
			endSize = 20;
			
			endSizeVariance = 150;
			
			lifespan = 0.1;
			lifespanVariance = 0.1;
			
			
			startColor.red = 0.7;
			startColor.blue = 1;
			startColor.green = 1;
			
			startColor.alpha = 0.8;
			endColor.alpha = -10;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			Starling.juggler.add(this);
			
			start();
			
			t = new Tween(this, 1);
			t.animate("maxRadius", 100);
			t.animate("minRadius", 100);
			t.animate("rotatePerSecond", 360 * 2);
			
			
			t.onComplete = reset;
			Starling.juggler.add(t);
			
		}
		
		private function reset():void 
		{
			stop();
			maxRadius = 10;   
			minRadius = 0;
			parent.removeChild(this);
			
			Starling.juggler.remove(this);
			Starling.juggler.remove(t);
		}
		
	}

}