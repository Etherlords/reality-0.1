package core.view.skin 
{
	import flash.display.Sprite;
	
	/**
	 * Реализация графики объекта может состоять из многих частей или из одного сплошноо спрайта по сути
	 * 
	 * Т.е мы можем в наследнике этого объекта(конечно можно изъебатся и сделать все универсально тут) сделать управление составным спрайтом сосотоящим из головы и тела например
	 * и он будет знать когда проиграть какую анмиацию головы, тела, ног, рук.
	 * Или же спрайт состоит из одного анимационного спрайта соответственно
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