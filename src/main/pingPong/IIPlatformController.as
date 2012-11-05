package pingPong 
{
	import com.greensock.TweenLite;
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
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
			var t:Timer = new Timer(10, 0);
			t.addEventListener(TimerEvent.TIMER, onFrameUpdate);
			t.start();
		}
		
		override protected function onFrameUpdate(e:Event):void 
		{
			super.onFrameUpdate(e);
			
			var __y:Number = boll.body.y + (platform.body.height - boll.body.height) / 2
			
			__y = __y - platform.body.height;
			
			if (__y < 0)
				__y = 0;
				
			if (__y > 400)
				__y = 400;
			
			platform.body.x = basex;
			TweenLite.to(platform.body, 0.0, { y:__y } );
			
			//setPlatformPosition();
			
		}
	
	}

}