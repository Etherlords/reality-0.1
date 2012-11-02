package pingPong 
{
	import core.view.skin.Skin;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class BollSkin extends Skin 
	{
		
		public function BollSkin() 
		{
			super();
			
			graphics.lineStyle(2, 0xCCCCCC);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, 23, 23);
		}
		
	}

}