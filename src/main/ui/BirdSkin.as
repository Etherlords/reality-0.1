package ui 
{
	import core.GlobalConstants;
	import core.view.skin.Skin;
	
	/**
	 * ...
	 * @author 
	 */
	public class BirdSkin extends Skin 
	{
		private var anim:BirdFlyAnimation;
		private var isFlyLeft:Boolean = true;
		
		public function BirdSkin() 
		{
			super();
			
			anim = new BirdFlyAnimation();
			
			anim.x = 20;
			anim.y = -15;
			addChild(anim);
		}
		
		override public function doAction(actionKey:uint):void 
		{
			
			if (isFlyLeft)
			{
				
				if (!direction.isLeftDiretion)
					anim.scaleX *= -1;
			}
			else
			{
				if (direction.isLeftDiretion)
					anim.scaleX *= -1;
			}
			
			isFlyLeft = direction.isLeftDiretion;
			
			/*if (actionKey == GlobalConstants.ACTION_DESTROY) 
			{
				removeChild(anim);
				parent.addChild(anim);
			}*/
		}
		
		override public function get phsyHeight():Number 
		{
			return 25
		}
		
		override public function get phsyWidth():Number 
		{
			return 40.2
		}
		
	}

}