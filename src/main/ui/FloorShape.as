package ui 
{
	import core.view.skin.Skin;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author 
	 */
	public class FloorShape extends Skin 
	{
		
		public function FloorShape() 
		{
			graphics.beginFill(0x0, 0.1);
			graphics.drawRect(0, 0, 760, 2);
		}
		
	}

}