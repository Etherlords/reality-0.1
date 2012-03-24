package core.view.skin 
{
import core.view.direction.Direction;

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
		}
		
		private var _direction:Direction;
		
		public function doAction(actionKey:uint):void
		{
			
		}

        public function get phsyWidth():Number {
            return this.width;
        }

        public function get phsyHeight():Number {
            return this.height;
        }

        public function get direction():Direction {
            return _direction;
        }

        public function set direction(value:Direction):void {
            _direction = value;
        }
    }

}