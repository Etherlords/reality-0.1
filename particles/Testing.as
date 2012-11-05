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
	
	public class Testing extends Sprite
	{
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private var InitValues:Class
		
		[Embed(source = "texture.png")]
		private var Sample:Class
		
		private var flow1:ParticleDesignerPS;
		private var t:Tween;
		private var q:Quad;
		private var tail:TailController;
		
		public function Testing() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// code goes here.
			
			/*
			Draw a little quad on stage,
			just to make sure everything's in place
			Note the top left corner of sprite is aligned to middle of stage
			
			q = new Quad(30, 30); addChild(q);
			q.color = 0xEEEEEE;
			q.x = stage.stageWidth >> 1; q.y = stage.stageHeight >> 1;
			*/
			stage.color = 0;	//turn stage colour to black
			tail = new TailController;
			addChild(tail)
			
			//adding interactivity
			stage.addEventListener(TouchEvent.TOUCH, track);
		}
		
		private function track(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			tail.emitAngle++;
			if (touch.phase == TouchPhase.MOVED) {
				//var distX:Number = touch.globalX - flow1.emitterX;
				//var distY:Number = touch.globalY - flow1.emitterY;
				//var angle:Number = Math.atan2(distY, distX);
				
				//t = new Tween(flow1, 1.5, Transitions.EASE_OUT_BACK);
				//t.animate("emitAngle", angle);
				
				//Starling.juggler.add(t);
			}
		}
	}

}