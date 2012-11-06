package pingPong.view.gameObjectsSkins 
{
	import core.view.skin.Skin;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class BollSkin extends Skin 
	{
		private var tail:TailController;
		private var lock:Boolean;
		
		public function BollSkin() 
		{
			super();
			
			graphics.lineStyle(2, 0xAAAAAA);
			graphics.beginFill(0xFFFFFF, 0.8);
			graphics.drawRect( 0, 0, 23, 23);
			
			
			//this.filters = [new BlurFilter(4, 4, 1)]
		}
		
		override public function get rotation():Number 
		{
			return super.rotation;
		}
		
		override public function set rotation(value:Number):void 
		{
			if(!StarlingInit.settings.isUseBollParticles)
				super.rotation = value;
		}
		
		override public function doAction(actionKey:uint, additionalParam:Number = 0):void 
		{	
			
			if (actionKey == 1)
			{
				lock = false;
				return;
			}
		
			if (StarlingInit.settings.isUseBollParticles)
			{
				tail.stop();
				tail.start();
			}
			
			
			x = (760 - phsyWidth / 2) / 2;
			y = (500 - phsyHeight / 2) / 2;
			lock = true
		}
		
		
		override public function set y(value:Number):void 
		{
			if (lock)
				return;
			super.y = value;
		}
		
		override public function set x(value:Number):void 
		{
			if (lock)
				return;
			super.x = value;
		}
		
		override public function prepareSkin():void 
		{
			var bm:BitmapData = new BitmapData(25, 25, true);
			var m:Matrix = new Matrix();
			m.tx = 1;
			m.ty = 1;
			
			bm.draw(shape, m);
			
			texture = Texture.fromBitmapData(bm, true);
			image = new Image(texture);
			image.smoothing = TextureSmoothing.TRILINEAR
			addChild(image);
			
			image.x -= 12;
			image.y -= 12;
			
			
			if (StarlingInit.settings.isUseBollParticles)
			{
				tail = new TailController();
				image.visible = false;
				addChild(tail)
			}
			
		}
		
		override public function get phsyHeight():Number 
		{
			return 25;
		}
		
		override public function get phsyWidth():Number 
		{
			return 25;
		}
		
	}

}