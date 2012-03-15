package ui 
{
	import core.view.skin.Skin;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class BulletSkin extends Skin 
	{
		
		public function BulletSkin() 
		{
			super();
			
			this.graphics.beginFill(0xFFFFFF, 0.9);
			this.graphics.drawCircle(0, 0, 6);
			
		
		}
		
	}

}