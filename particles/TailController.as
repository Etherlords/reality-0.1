package  
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Nikro
	 */
	public class TailController extends ParticleDesignerPS
	{
		
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		private var flow1:ParticleDesignerPS;
		private var t:Tween;
		private var q:Quad;
		
		public function TailController() 
		{
			
			super(	XML(new InitValues()), Texture.fromBitmap(new Sample())		);
				
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		protected function onInit(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			//emitterX = stage.stageWidth >> 1; 		//centering onto stage
			//emitterY = stage.stageHeight >> 1;
			start();
			emitterType = 1;
			maxNumParticles = 150;
			rotatePerSecond = 360;
			maxRadius = 15;
			minRadius = 5;
			
			startSize = 25;
			endSize = 30;
			endSizeVariance = 20;
			startSizeVariance = 30;
			
			lifespan = 15
			lifespanVariance = 5.9;
			emitterXVariance = 10;
			emitterYVariance = 10;
			//speed = 100;
			startColor.red = 1;
			startColor.blue = 1;
			startColor.green = 1;
			
			startColor.red = 0.6;
			startColor.blue = 1;
			startColor.green = 1;
			
			startColor.alpha = 0.8;
			endColor.alpha = 0;
			
			
			
			Starling.juggler.add(this);
		}
		
	}

}