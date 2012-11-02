package pingPong 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import core.view.skin.Skin;
	
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
		
		override public function doAction(actionKey:uint):void 
		{
			TweenMax.to(this, 0.5, { colorTransform: { tint:0xFFFFFF, tintAmount:0.9 }, onComplete:titntBack } );
		}
		
		private function titntBack():void 
		{
			TweenMax.to(this, 0.2, {colorTransform:{tint:0xFFFFFF, tintAmount:0}});
		}
		
	}

}