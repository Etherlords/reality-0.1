package  
{
	import flash.display.Bitmap;
	import flash.display3D.Context3DBlendFactor;
	import flash.ui.Keyboard;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ColorArgb;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Shiu
	 */
	
	public class TestingBurn extends Sprite
	{
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		[Embed(source = "boss1.png")]
		private var Ship:Class
		
		private var flow1:ParticleDesignerPS; 
		private var envr:ParticleDesignerPS;
		private var t:Tween, t2:Tween;
		private var loc:Vector2D;
		private var lof:Vector2D;
		private var theShip:Sprite;
		private var offset:Vector2D;
		private var angle:Number = Math.PI * 0.5;
		
		public function TestingBurn() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// code goes here.
			
			//setup the stage 
			stage.color = 0;
			
			//setup the exhaust
			flow1 = new ParticleDesignerPS( XML(new InitValues()), 					
				Texture.fromBitmap(new Sample())	
				);
			addChild(flow1);
			flow1.emitterX = stage.stageWidth >> 1;
			flow1.emitterY = stage.stageHeight >> 1;
			flow1.startColor = new ColorArgb(0, 1.0, 1.0, 1.0);
			flow1.endColor = new ColorArgb(1.0, 1.0, 1.0, 1.0);
			flow1.start();
			Starling.juggler.add(flow1);
			
			//setup the ship's graphical apperance
			var shipBMP:Bitmap = new Ship() as Bitmap;
			var shipTEX:Texture = Texture.fromBitmap(shipBMP);
			var shipIMG:Image = new Image(shipTEX);	
			
			//setup ship's orientation & position
			shipIMG.rotation -= Math.PI*0.5;	
			shipIMG.x -= shipIMG.width >> 1;	
			shipIMG.y += shipIMG.height >> 1;	
			theShip = new Sprite();
			theShip.addChild(shipIMG);
			addChildAt(theShip, 0);
			
			//navigational properties of ship
			loc = new Vector2D(stage.stageWidth >> 1, stage.stageHeight >> 1);
			lof = new Vector2D(0, 10);
			
			//environment
			envr = new ParticleDesignerPS( XML(new InitValues()), 					
				Texture.fromBitmap(new Sample())	
				);
			addChildAt(envr,2);
			envr.blendFactorSource = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA
			envr.blendFactorDestination = Context3DBlendFactor.ONE;
			envr.emitterXVariance = theShip.width >> 2;
			envr.emitterYVariance = theShip.height >> 2;
			envr.emitAngle = 0;		envr.emitAngleVariance = Math.PI;
			envr.speed = 0;			
			envr.startSize = 40;	envr.startSizeVariance = 0;
			envr.endSize = 10;		envr.endSizeVariance = 0
			envr.lifespan = 5.0;	envr.lifespanVariance = 3.0;
			envr.emissionRate = 10;
			envr.start(); Starling.juggler.add(envr);
			
			updateShip();
			
			//adding interactivity
			stage.addEventListener(TouchEvent.TOUCH, track);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, controlBurn);
		}
		
		private function controlBurn(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.A) {
				if(envr.emissionRate < 150)	envr.emissionRate += 10;
				if (envr.lifespan < 8)	envr.lifespan += 0.5;
			}
			if (e.keyCode == Keyboard.S) {
				if(envr.emissionRate > 10)	envr.emissionRate -= 10;
				if (envr.lifespan > 5)	envr.lifespan -= 0.5;
			}
		}
		
		private function updateShip():void {
			theShip.x = loc.x;
			theShip.y = loc.y;
			theShip.rotation = lof.getAngle();
			
			//update particle trail, to highlight
			offset = new Vector2D(60, 0);
			offset.setAngle(lof.getAngle());
			flow1.emitterX = loc.x - offset.x;
			flow1.emitterY = loc.y - offset.y;
			
			//update the environment
			envr.gravityX = -10*lof.x;
			envr.gravityY = -10*lof.y;
			envr.emitterX = loc.x
			envr.emitterY = loc.y
		}
		
		private function track(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (touch.phase == TouchPhase.MOVED) {
				var distX:Number = touch.globalX - flow1.emitterX;
				var distY:Number = touch.globalY - flow1.emitterY;
				angle = Math.atan2(distY, distX);
				
				//animate the exhaust
				t = new Tween(flow1, 1.5, Transitions.EASE_OUT_BACK);
				t.animate("emitAngle", angle + Math.PI);
				Starling.juggler.add(t);	
				
				//control the exhaust
				flow1.speed = 350;
				flow1.endSize = 70;
				
				//orient the ship & parallax's angle
				lof.setAngle(angle);
				lof.setMagnitude(10);	//adjust the magnitude of acceleration
			}
			if (touch.phase == TouchPhase.ENDED) {
				
				//control the exhaust
				flow1.speed = 100;
				flow1.endSize = 10;
				
				lof.setMagnitude(5);	//adjust the magnitude of acceleration
			}
			updateShip();
		}
	}

}