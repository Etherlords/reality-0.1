package ui.rabbit 
{
import core.GlobalConstants;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import flash.geom.Point;

import flash.display.Sprite;

/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		//public var movementFlag:
		
		public function Rabbit(config:GameobjectConfig, instance:Sprite) 
		{
			super(config, instance);
			
			
		}
		
		public function applyMove(force:Number):void
		{
			var linearVelocity:Point = physicalProperties.linearVelocity;
			linearVelocity.x /= 4.5;
			physicalProperties.linearVelocity = linearVelocity;
			//physicalProperties.stopXVelocity();
			physicalProperties.applyImpulse(force, 0);
		}
		
        override public function preRender(lastPreRenderCallDelay:uint):void
		{
            super.preRender(lastPreRenderCallDelay);
			applyActionView(0);
        }
    }

}