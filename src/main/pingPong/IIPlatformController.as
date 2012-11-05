package pingPong 
{
	import com.greensock.TweenLite;
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IIPlatformController extends PlayerPlatformController 
	{
		private var boll:GameObject;
		
		public function IIPlatformController(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, platform:GameObject, boll:GameObject) 
		{
			super(viewInstance, worldController, platform);
			this.boll = boll;
			
		}
		
		
		override protected function initilize():void 
		{
			var t:Timer = new Timer(20, 0);
			t.addEventListener(TimerEvent.TIMER, onTimerEvent);
			t.start();
		}
		
		private function onTimerEvent(e:TimerEvent):void 
		{
			onFrameUpdate();
		}
		
		override protected function onFrameUpdate(e:Event = null):void 
		{
			super.onFrameUpdate(e);
			
			var __y:Number = boll.body.y + (platform.body.height - boll.body.height) / 2;
			/*
			if (Math.random() > 0.5)
			{
				if (Math.random() > 0.5)
					__y += boll.body.width *2;
				else
					__y -= boll.body.width *2;
			}*/
			
			__y = __y - platform.body.height;
			
			if (__y < 0)
				__y = 0;
				
			if (__y > 400)
				__y = 400;
			
			platform.body.x = basex;
			TweenLite.to(platform.body, 0.03, { y:__y } );
			
			//setPlatformPosition();
			
		}
	
	}

}