/**
 * author: chaos-encoder
 * Date: 01.02.12 Time: 7:47
 */
package ui.rabbit 
{
	import core.GlobalConstants;
	import core.view.skin.AnimatedSprite;
	import core.view.skin.Skin;
	import flash.display.MovieClip;

	public class RabbitSkin extends Skin 
	{
		
		private var left:MovieClip;
		private var right:MovieClip;
		private var jumpRight:MovieClip;
		private var jumpLeft:MovieClip;
		private var standLeft:StandAnimation;
		private var standRight:StandAnimation;
		
		private var isRight:Boolean = true;
		
		private var _physWidht:Number = 0;
		private var _physHeight:Number = 0;
		
		
		public function RabbitSkin() 
		{
			super();
			
			this.scaleX = this.scaleY = 0.5;
		   
			left = new WalkLeft();
			right = new WalkLeft();
			standLeft = new StandAnimation();
			standRight = new StandAnimation();
			
			standRight.scaleX *= -1;
			standRight.x = standRight.width + 5;
			
			right.scaleX *= -1;
			right.x = left.x = 40;
			//right.x += 53.15
			//left.x += 53.15
			
			jumpRight = new JumpAnimation();
			jumpLeft = new JumpAnimation();
			
			jumpRight.scaleX *= -1;
			
			left.visible = false;
			right.visible = false;
			jumpRight.visible = false;
			jumpLeft.visible = false;
			
			addChild(left);
			addChild(right);
			addChild(jumpRight);
			addChild(jumpLeft);
			addChild(standLeft);
			addChild(standRight);
			
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

		override public function doAction(actionKey:uint):void 
		{
			super.doAction(actionKey);
			
			left.visible = right.visible = jumpLeft.visible = jumpRight.visible = standLeft.visible = standRight.visible = false;
			
			var stand:StandAnimation
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
				//trace("IS STAND");
				
				
				
				stand.visible = true;
				stand.standUp();
				
			}
			else
			{
				
				standRight._isPlaying = false;
				standLeft._isPlaying = false;
			}
				
			if (direction.isJumping || direction.isFalling)
			{
				stand.gotoAndStop(0);
				stand.visible = true;
			}
			
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

