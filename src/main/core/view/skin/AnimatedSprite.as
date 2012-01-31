package core.view.skin 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class AnimatedSprite extends Sprite
	{
		
		private var spriteName:String
		
		public function AnimatedSprite() 
		{
			this.graphics.beginFill(0xFFFFFF);
			
			this.graphics.drawRect(0, 0, 20, 20);
			
			this.graphics.endFill();
		}
		
	}

}