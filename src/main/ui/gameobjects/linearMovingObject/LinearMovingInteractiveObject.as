package ui.gameobjects.linearMovingObject 
{
	import core.locators.ServicesLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

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
		private var moveSpeed:Number = 2.5
		private var flowStopped:Boolean = false;
		
		private var birdBehavior:Function;
		
		
		public function LinearMovingInteractiveObject(config:GameobjectConfig, interactiveObjectConfig:InteractiveObjectConfiguration, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher=null) 
		{
			config.physicConfiguration.density = 2.1;
			config.physicConfiguration.friction = 0.3;
			config.physicConfiguration.restitution = 0.1;
			config.physicConfiguration.fixedRotation = true;
			
			birdBehavior = linearMoving;
			
			super(config, interactiveObjectConfig, instance, eventFlowTarget);
			
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			(physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetSensor(true);
			
			
		}
		
		override public function render():void 
		{
			birdBehavior();
			skin.doAction(0);
			super.render();
		}
		
		override public function destroy():void 
		{
			//	super.destroy();
			
			//(physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetDensity(5);
			//(physicalProperties as SimplePhysicalProperties).physicBodyKey.SetFixedRotation(false);
			//(physicalProperties as SimplePhysicalProperties).physicBodyKey.ResetMassData();
			//(physicalProperties as SimplePhysicalProperties).physicBodyKey.ApplyTorque(3 + Math.random() * 5 * moveDirection);
			
			moveSpeed = 15;
			birdBehavior = goAway;
		}
		
		private function goAway():void 
		{
			if (body.x < 0)
				super.destroy();
				
			if (body.x > 760)
				super.destroy();
			
			var linearVelocity:Point = physicalProperties.linearVelocity
			linearVelocity.x = moveSpeed * moveDirection;
			//linearVelocity.y = -0.4
			
			physicalProperties.linearVelocity = linearVelocity;
		}
		
		private function linearMoving():void 
		{
			if (body.x < 10)
				moveDirection = 1;
				
			if (body.x > 700)
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