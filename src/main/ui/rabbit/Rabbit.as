package ui.rabbit 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

import core.GlobalConstants;
import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		
		
		public function Rabbit(config:GameobjectConfig, instance:Sprite) 
		{
			super(config, instance);
		}
		
		public function applyMove(force:Number):void
		{
			physicalProperties.stopXVelocity();
			physicalProperties.applyImpulse(force, 0);
		}
		
        override public function preRender():void 
		{
            super.preRender();
			
            if ((Math.abs(physicalProperties.linearVelocity.y) > 0.2)) 
			{
				if (physicalProperties.linearVelocity.x > 0) 
				{
					applyActionView(GlobalConstants.ACTION_VIEW_JUMP_RIGHT);
				} 
				else 
				{
					applyActionView(GlobalConstants.ACTION_VIEW_JUMP_LEFT);
				}
               
            }
			else if (Math.abs(physicalProperties.linearVelocity.x) > 0.2) 
			{
				var actionViewKey:uint = physicalProperties.linearVelocity.x > 0 ? GlobalConstants.ACTION_VIEW_WALK_RIGHT : GlobalConstants.ACTION_VIEW_WALK_LEFT;	
				applyActionView(actionViewKey);
			} 
			else 
			{
				applyActionView(GlobalConstants.ACTION_VIEW_WALK_LEFT);
			}
        }

        public function isLevitation():Boolean {  //todo remove quickfix
            return (skin as RabbitSkin).isLevitationAppearance();
        }
    }

}