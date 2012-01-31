package core.view.skin 
{
	import flash.display.Sprite;
	
	/**
	 * Реализация графики объекта может состоять из многих частей или из одного сплошноо спрайта по сути
	 * @author 
	 */
	public class Skin extends Sprite 
	{
		
		public function Skin() 
		{
			super();
			
			addChild(new AnimatedSprite());
		}
		
		public function doAction(actionKey:uint):void
		{
			
		}
		
		protected function addSprite(sprite:AnimatedSprite):void
		{
			
		}
		
	}

}