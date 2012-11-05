package pingPong 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import core.view.skin.Skin;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlatformSkin extends Skin 
	{
		
		public function PlatformSkin() 
		{
			super();
			
			graphics.lineStyle(2, 0x888888);
			graphics.beginFill(0xCCCCCC);
			graphics.drawRect(0, 0, 25, 100);
		}
		
		private var startx:Number = 0;
		private var lock:Boolean = false;
		private var lock2:Boolean = false;
		
		override public function prepareSkin():void 
		{
			var bm:BitmapData = new BitmapData(shape.width + 1, shape.height + 1, true);
			var m:Matrix = new Matrix();
			m.tx = 1;
			m.ty = 1;
			
			bm.draw(shape, m);
			
			texture = Texture.fromBitmapData(bm);
			image = new Image(texture);
			addChild(image);
			
			//image.x -= 12;
			//image.y -= 12;
		}
		
		override public function doAction(actionKey:uint, horSpeed:Number = 0):void 
		{
			if (actionKey == 5)
			{
				lock = false;
				lock2 = false;
				this.x = horSpeed;
				return;
			}
			
			if (actionKey == 4 && !lock2)
			{
				TweenMax.killTweensOf(this);
				lock = false
				lock2 = true;
				return;
			}
				
			if (lock || lock2)
				return;
			
			var dir:int = 1;
			if (actionKey == 1)
				dir = -1;
				
			horSpeed = Math.abs(horSpeed) / 2;
			
			if (horSpeed > 20)
				horSpeed = 20;
				
			startx = this.x;
			lock = true;
			//TweenMax.to(this, 0.5, { colorTransform:{ tint:0xFFFFFF, tintAmount:0.9 }, onComplete:titntBack } );
			//TweenMax.to(this, 0.1, { superx:(dir * horSpeed) + this.x});
		}
		
		
		public function get superx():Number 
		{
			return super.x;
		}
		
		public function set superx(value:Number):void 
		{
			
				
			super.x = value;
		}
		
		override public function get x():Number 
		{
			return super.x;
		}
		
		override public function set x(value:Number):void 
		{
			if (lock)
				return;
				
			super.x = value;
		}
		
		private function titntBack():void 
		{
			
			TweenMax.to(this, 0.5, {superx:startx, colorTransform:{tint:0xFFFFFF, tintAmount:0}, onComplete:unlock});
		}
		
		private function unlock():void 
		{
			lock = false;
		}
		
	}

}