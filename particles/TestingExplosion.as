package  
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Shiu
	 */
	
	public class TestingExplosion extends Sprite
	{
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		private var explosion:ParticleDesignerPS;
		private var t:Tween;
		
		public function TestingExplosion() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// code goes here.
			
			stage.color = 0;	//turn stage colour to black
			
			explosion = 
			new ParticleDesignerPS(
					XML(new InitValues()), 					
					Texture.fromBitmap(new Sample())
				);
			addChild(explosion);
			explosion.emitterX = stage.stageWidth >> 1; 	
			explosion.emitterY = stage.stageHeight >> 1;
			explosion.emitterType = 1;
			explosion.emitAngle = 0;	explosion.emitAngleVariance = Math.PI;
			explosion.maxRadius = 10;	explosion.maxRadiusVariance = 0;
			explosion.minRadius = 0;
			
			Starling.juggler.add(explosion);
			
			//adding interactivity
			stage.addEventListener(TouchEvent.TOUCH, track);
		}
		
		private function track(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (touch.phase == TouchPhase.BEGAN) {
				explosion.emitterX = touch.globalX;
				explosion.emitterY = touch.globalY;
				explosion.start();
				t = new Tween(explosion, 1.0, Transitions.EASE_IN);
				t.animate("maxRadius", 150);
				t.animate("minRadius", 130);
				t.onStart = freeze
				t.onComplete = reset;
				Starling.juggler.add(t);
			}
		}
		
		private function freeze():void {
			stage.removeEventListener(TouchEvent.TOUCH, track);
		}
		
		private function reset():void {
			stage.addEventListener(TouchEvent.TOUCH, track);
			explosion.stop();
			explosion.maxRadius = 10;	
			explosion.minRadius = 0;
		}
	}

}