package ui 
{
	import core.view.skin.Skin;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaloonShape extends Skin 
	{
		
		public function BaloonShape() 
		{
			super();
			this.graphics.lineStyle(1);
			this.graphics.beginFill(0xFFFFFF, 0.9);
			this.graphics.drawCircle(30, 30, 30);
			
		
		}
		
	}

}