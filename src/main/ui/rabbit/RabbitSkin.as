/**
 * author: chaos-encoder
 * Date: 01.02.12 Time: 7:47
 */
package ui.rabbit 
{
import core.GlobalConstants;
import core.view.skin.Skin;

import flash.display.MovieClip;

public class RabbitSkin extends Skin
	{
		
		private var left:MovieClip;
		private var right:MovieClip;
		private var jumpRight:JumpAnimation;
		private var jumpLeft:JumpAnimation;
		private var standLeft:StandAnimation;
		private var standRight:StandAnimation;
		
		private var isRight:Boolean = true;
		
		private var _physWidht:Number = 0;
		private var _physHeight:Number = 0;
		private var flyRight:FlyingAnimation;
		private var flyLeft:FlyingAnimation;
        private var deathLeft:DeathLeftAnimation;
        private var deathRight:DeathLeftAnimation;

        private var wasDided:Boolean = false;

		public function RabbitSkin() 
		{
			super();
			
			this.scaleX = this.scaleY = 0.5;
		   
			left = new WalkLeft();
			right = new WalkLeft();
			standLeft = new StandAnimation();
			standRight = new StandAnimation();
			
			flyRight = new FlyingAnimation();
			flyLeft = new FlyingAnimation();
			
			
			
			//flyLeft.scaleX *= -1;
			
			
			standRight.scaleX *= -1;
			standRight.x = standRight.width + 5;
			
			right.scaleX *= -1;
			right.x = left.x = 40;
			flyLeft.x = flyRight.x = 40;

			//right.x += 53.15
			//left.x += 53.15
			
			jumpRight = new JumpAnimation();
			jumpLeft = new JumpAnimation();
			
			jumpRight.scaleX *= -1;
			
			left.visible = false;
			right.visible = false;
			jumpRight.visible = false;
			jumpLeft.visible = false;


            deathLeft = new DeathLeftAnimation();
            deathRight = new DeathLeftAnimation();
            deathRight.scaleX *= -1;
            deathRight.visible = deathLeft.visible = false;

			addChild(left);
			addChild(right);
			addChild(jumpRight);
			addChild(jumpLeft);
			addChild(standLeft);
			addChild(standRight);
			
			addChild(flyRight);
			addChild(flyLeft);
			addChild(deathLeft);
			addChild(deathRight);


			
			_physHeight = 25;
			_physWidht = 40;
		}
		
		override public function get phsyHeight():Number 
		{
			return _physHeight;
		}
		
		override public function get phsyWidth():Number 
		{
			return _physWidht;
		}

		public function resetFlyAnim():void
		{
			flyRight._isPlaying = false;
			flyLeft._isPlaying = false;
		}
		
		private var isFlyLeft:Boolean = true;
		
		override public function doAction(actionKey:uint):void 
		{
			super.doAction(actionKey);
			if (wasDided) {
                return;
            }

			left.visible = right.visible = jumpLeft.visible = jumpRight.visible = standLeft.visible = standRight.visible = false;
			flyLeft.visible = flyRight.visible = false;

            if (actionKey == GlobalConstants.ACTION_VIEW_EXPOSE_ON_FLOOR) {
                wasDided = true;
                if (direction.isLeftDiretion) {
                    deathLeft.visible = true;
                    deathLeft.play();
                } else {
                    deathRight.visible = true;
                    deathRight.play();
                }
                return;
            }

			
			var stand:StandAnimation;
			var fly:FlyingAnimation;
		
			
			if (direction.isLeftDiretion)
			{
				stand = standLeft
			}
			else
			{
				stand = standRight;
			}
			
			if (direction.isStand)
			{	
				stand.visible = true;
				stand.standUp();
			}
			else
			{
				
				standRight._isPlaying = false;
				standLeft._isPlaying = false;
			}
			
			
			//TODO: хардкод сделано чтобы заяц не мерцал когда линейцное ускорение становится 0
			//if (!direction.isWalking && !direction.isStand)
			//{
			/*	if (direction.isFalling)
				{
					if (direction.isLeftDiretion)
					{
						falling = fallRight;
					}
					else
					{
						falling = fallLeft;
					}
					
					falling.standUp();
					falling.visible = true;
				}
				else
				{
					fallRight._isPlaying = false;
					fallLeft._isPlaying = false;
				}*/
				
				//if (direction.isJumping || direction.isFalling || (!direction.isWalking && !direction.isStand))
				//{
				//	stand.gotoAndStop(0);
				//	stand.visible = true;
				//}
				
				if (direction.isJumping || direction.isFalling || (!direction.isWalking && !direction.isStand))
				{
					if (isFlyLeft)
					{
						if (!direction.isLeftDiretion)
							flyLeft.scaleX *= -1;
					}
					else
					{
						if (direction.isLeftDiretion)
							flyLeft.scaleX *= -1;
					}
					
					isFlyLeft = direction.isLeftDiretion;
					
					
					flyLeft.standUp();
					flyLeft.visible = true;
				}
				else
				{
					flyLeft._isPlaying = false;
				}
			//}
			
			
			if (direction.isWalking)
			{
				if (direction.isLeftDiretion)
				{
					left.visible = true;
				}
				else
				{
					right.visible = true;
				}
			}
			
			
			
			
			if (actionKey == GlobalConstants.ACTION_VIEW_FLAP_WINGS) 
			{
				//jumpLeft.flapWings();
				//jumpRight.flapWings();
			}
			
		}
	}
}

