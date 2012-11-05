package  
{
	import flash.display.Bitmap;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
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
	
	public class TestingShip extends Sprite
	{
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		[Embed(source = "boss1.png")]
		private var Ship:Class
		
		private var flow1:ParticleDesignerPS;
		private var t:Tween, t2:Tween;
		private var loc:Vector2D;
		private var lof:Vector2D;
		private var theShip:Sprite;
		private var offset:Vector2D;
		private var angle:Number;
		
		public function TestingShip() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// code goes here.
			
			stage.color = 0;	//turn stage colour to black
			flow1 = 
			new ParticleDesignerPS(
					XML(new InitValues()), 						//XML containing all initial values
					Texture.fromBitmap(new Sample())	//image to sample for all particles
				);
			addChild(flow1);
			flow1.emitterX = stage.stageWidth >> 1; 		//centering onto stage
			flow1.emitterY = stage.stageHeight >> 1;
			flow1.start();
			Starling.juggler.add(flow1);
			
			//adding interactivity
			stage.addEventListener(TouchEvent.TOUCH, track);
			
			//setup the graphical apperance
			var shipBMP:Bitmap = new Ship() as Bitmap;	//import asset into a bmp
			var shipTEX:Texture = Texture.fromBitmap(shipBMP);	//sample bmp as texture to image
			var shipIMG:Image = new Image(shipTEX);	//image created with texture
			
			//setup ship's orientation & position
			shipIMG.rotation -= Math.PI*0.5;	//reorient the image
			shipIMG.x -= shipIMG.width >> 1;	//because image's origin is at top left corner,
			shipIMG.y += shipIMG.height >> 1;	//we reposition the image
			theShip = new Sprite();	//and put it into a sprite. Now registration point is centered.
			theShip.addChild(shipIMG);	//sprite placed onto stage
			addChildAt(theShip, 0);
			
			//navigational properties of ship
			loc = new Vector2D(stage.stageWidth >> 1, stage.stageHeight >> 1);
			lof = new Vector2D(0, 10);
			
			updateShip();
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
		}
		
		private function track(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (touch.phase == TouchPhase.MOVED) {
				var distX:Number = touch.globalX - flow1.emitterX;
				var distY:Number = touch.globalY - flow1.emitterY;
				angle = Math.atan2(distY, distX);
				
				t = new Tween(flow1, 1.5, Transitions.EASE_OUT_BACK);
				t.animate("emitAngle", angle + Math.PI);
				
				t2 = new Tween(theShip, 1.5, Transitions.EASE_OUT);
				t2.moveTo(touch.globalX, touch.globalY);	//move the ship
				t2.onUpdate = refresh	//call upon this function whenever tween engine runs
				t2.onStart = beginState	//when ship starts moving
				t2.onComplete = endState//when ship animation stops
				
				Starling.juggler.add(t);
				Starling.juggler.add(t2);	//add to juggler
			}
			
		}
		
		private function refresh():void {
			loc.x = theShip.x;	//refresh location
			loc.y = theShip.y;
			lof.setAngle(angle);	//refresh orientation
			
			updateShip();	// update 
		}
		
		private function beginState():void {
			flow1.emissionRate = 250
			flow1.speed = 100;
		}
		
		private function endState():void {
			flow1.emissionRate = 50
			flow1.speed = 10;
		}
	}

}