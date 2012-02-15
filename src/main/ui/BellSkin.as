package ui 
{
	import core.GlobalConstants;
	import core.view.skin.Skin;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public class BellSkin extends Skin 
	{
		private var anim:BellAnimation;
		private var destroyAnim:BellDestroyAnimation;
		
		
		public function BellSkin() 
		{
			super();
			
			anim = new BellAnimation();
			destroyAnim = new BellDestroyAnimation();
			
			anim.x = 2.5;
			destroyAnim.x = 2.5;
			
			
			//anim.y = -15;
			addChild(anim);
			
		}
		
		override public function doAction(actionKey:uint):void 
		{
			
			if (actionKey == GlobalConstants.ACTION_DESTROY)
			{
				var stars:StarAnimation = new StarAnimation();
				var viewInstance:DisplayObjectContainer = anim.parent.parent
				
				anim.visible = false;
				
				destroyAnim.visible = true;
				destroyAnim.gotoAndPlay(0);
				
				viewInstance.addChild(destroyAnim)
				
				viewInstance.addChild(stars);
				
				stars.x = anim.parent.x + 15
				stars.y = anim.parent.y + 40;
				
				
				destroyAnim.x = anim.parent.x;
				destroyAnim.y = anim.parent.y;
			}
		}
		
		override public function get phsyHeight():Number 
		{
			return 31
		}
		
		override public function get phsyWidth():Number 
		{
			return 35;
		}
		
	}

}