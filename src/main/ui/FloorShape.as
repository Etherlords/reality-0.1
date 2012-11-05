package ui 
{
	import com.greensock.TweenMax;
	import core.view.skin.Skin;
	
	/**
	 * ...
	 * @author 
	 */
	public class FloorShape extends Skin 
	{


		public function FloorShape() 
		{
			
			graphics.lineStyle(2, 0x888888);
			graphics.beginFill(0xCCCCCC);
			graphics.drawRect(0, -2, 760, 2);
		
			
		}
		
		override public function doAction(actionKey:uint):void 
		{
			trace('do action');
			TweenMax.to(this, 0.5, { colorTransform: { tint:0xFFFFFF, tintAmount:0.9 }, onComplete:titntBack } );
		}
		
		private function titntBack():void 
		{
			TweenMax.to(this, 0.2, {colorTransform:{tint:0xFFFFFF, tintAmount:0}});
		}
		
	}

}