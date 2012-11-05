package pingPong 
{
	import core.view.skin.Skin;
	import flash.filters.BlurFilter;
	
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
			graphics.beginFill(0xFFFFFF, 0.8);
			graphics.drawRect( -12, -12, 23, 23);
			
			this.filters = [new BlurFilter(4, 4, 1)]
		}
		
	}

}