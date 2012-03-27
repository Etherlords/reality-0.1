package ui 
{
import core.view.skin.Skin;

/**
	 * ...
	 * @author 
	 */
	public class BulletSkin extends Skin 
	{
		
		public function BulletSkin() 
		{
			super();
			
			addChild(new BulletSymbol());
			
		
		}
		
	}

}