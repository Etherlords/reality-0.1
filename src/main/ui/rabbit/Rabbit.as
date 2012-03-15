package ui.rabbit 
{
import core.GlobalConstants;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.GameObject;
import core.view.gameobject.physicalpropeties.PhysicModel;
import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;
import flash.geom.Point;


/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		//public var movementFlag:
		
		public function Rabbit(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) 
		{
			super(config, physicModel, instance, eventFlowTarget);
			
			
		}
		
		public function resetFlyAnim():void
		{
			skin['resetFlyAnim']();
		}
		
		public function applyMove(force:Number):void
		{
			var linearVelocity:Point = physicalProperties.physicModel.linearVelocity;
			linearVelocity.x /= 6.5;
			linearVelocity.x += force;
			//physicalProperties.physicModel.linearVelocity = linearVelocity;
			//physicalProperties.stopXVelocity();
			//physicalProperties.applyImpulse(force, 0);
			physicalProperties.physicBodyKey.SetAwake(true);
			physicalProperties.physicModel.linearVelocity = linearVelocity;
			
		}
		
        override public function preRender(lastPreRenderCallDelay:uint):void
		{
            super.preRender(lastPreRenderCallDelay);
			applyActionView(0);
        }
    }

}