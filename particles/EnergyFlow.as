package  
{
	import flash.display3D.Context3DBlendFactor;
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
	public class EnergyFlow extends ParticleDesignerPS
	{
		
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		public function EnergyFlow() 
		{
			
			super(	XML(new InitValues()), Texture.fromBitmap(new Sample(), false, true), Context3DBlendFactor.ONE		);
				
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		protected function onInit(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			start();
			emitterType = 0;
			maxNumParticles = 30;
			
			rotatePerSecond = 0;
			
			maxRadius = 15;
			minRadius = 3;
			
			speed = 0;
			speedVariance = 0
			
			startSize = 5;
			endSize = 2;
			endSizeVariance = 4;
			startSizeVariance = 15;
			
			this.gravityY = 25;
			
			lifespan = 1
			lifespanVariance = 2;
			
			emitterXVariance = 12;
			emitterYVariance = 10;
			
			startColor.red = 0.6;
			startColor.blue = 1;
			startColor.green = 1;
			
			endColor.red = 1;
			endColor.blue = 1;
			endColor.green = 1;
			
			
			
			startColor.alpha = 1;
			endColor.alpha = 0.9;
			
			
			
			Starling.juggler.add(this);
		}
		
	}

}