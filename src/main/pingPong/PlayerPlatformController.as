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
		
		private var _basex:Number = 0;
		
		public function PlayerPlatformController(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, platform:GameObject) 
		{
			this.platform = platform;
			this.worldController = worldController;
			this.viewInstance = viewInstance;
			
			basex = platform.body.x;
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
			
			platform.body.x = basex;
			platform.body.y = __y;
		}
		
		public function get basex():Number 
		{
			return _basex;
		}
		
		public function set basex(value:Number):void 
		{
			_basex = value;
			platform.body.x = basex;
		}
		
	}

}