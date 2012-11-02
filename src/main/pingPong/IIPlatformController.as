package pingPong 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
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
			viewInstance.addEventListener(Event.ENTER_FRAME, onFrameUpdate);
		}
		
		override protected function onFrameUpdate(e:Event):void 
		{
			super.onFrameUpdate(e);
			
			setPlatformPosition(boll.body.y + (platform.body.height - boll.body.height)/2);
			
		}
	
	}

}