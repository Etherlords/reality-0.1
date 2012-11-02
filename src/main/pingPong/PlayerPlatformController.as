package pingPong 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.rabbit.constructor.PlayerConstructor;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlayerPlatformController 
	{
		protected var viewInstance:DisplayObjectContainer;
		protected var worldController:Box2DWorldController;
		protected var platform:GameObject;
		
		public function PlayerPlatformController(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, platform:GameObject) 
		{
			this.platform = platform;
			this.worldController = worldController;
			this.viewInstance = viewInstance;
			
			
			initilize();
		}
		
		protected function initilize():void 
		{
			viewInstance.addEventListener(Event.ENTER_FRAME, onFrameUpdate);
			viewInstance.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			setPlatformPosition(viewInstance.stage.mouseY);
		}
		
		protected function onFrameUpdate(e:Event):void 
		{
			platform.physicalProperties.stopXVelocity();
			platform.physicalProperties.stopYVelocity();
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			setPlatformPosition(e.stageY);
		}
		
		protected function setPlatformPosition(position:Number):void
		{
			var __y:Number = position - platform.body.height;
			
			if (__y < 0)
				__y = 0;
				
			if (__y > 400)
				__y = 400;
			
			
			platform.body.y = __y;
		}
		
	}

}