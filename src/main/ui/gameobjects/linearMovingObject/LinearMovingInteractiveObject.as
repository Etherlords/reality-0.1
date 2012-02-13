package ui.gameobjects.linearMovingObject 
{
	import core.locators.ServicesLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import ui.gameobjects.BaseInteractiveGameObject;
	import ui.gameobjects.datavalues.InteractiveObjectConfiguration;
	
	/**
	 * ...
	 * @author 
	 */
	public class LinearMovingInteractiveObject extends BaseInteractiveGameObject 
	{
		private var moveDirection:int = 1;
		private var moveSpeed:Number = 5
		private var flowStopped:Boolean = false;
		
		
		public function LinearMovingInteractiveObject(config:GameobjectConfig, interactiveObjectConfig:InteractiveObjectConfiguration, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher=null) 
		{
			config.physicConfiguration.density = 2.1;
			config.physicConfiguration.friction = 0.3;
			config.physicConfiguration.restitution = 0.1;
			config.physicConfiguration.fixedRotation = true;
			
			super(config, interactiveObjectConfig, instance, eventFlowTarget);
			
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			(physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetSensor(true);
		}
		
		override public function render():void 
		{
			linearMoving();
			super.render();
		}
		
		private function linearMoving():void 
		{
			if (body.x < 10)
				moveDirection = 1;
				
			if (body.x > 760)
				moveDirection = -1;
				
			if (!(ServicesLocator.cameraService.camera.target.y > 200) && !flowStopped )
			{
				//TODO: вынести куда нибудь
				(physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetDensity(2);
				(physicalProperties as SimplePhysicalProperties).physicBodyKey.ResetMassData();
				
				flowStopped = true;
			}
				
			var linearVelocity:Point = physicalProperties.linearVelocity
			linearVelocity.x = moveSpeed * moveDirection;
			//linearVelocity.y = -0.4
			
			physicalProperties.linearVelocity = linearVelocity;
		}
	}

}