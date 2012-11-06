package ui.components 
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Switch extends Sprite 
	{
		private var borderWidth:Number;
		private var borderHeight:Number;
		
		private var statusBur:Sprite = new Sprite();
		public var status:Boolean = false;
		
		public function Switch( status:Boolean = false, scale:Number = 4) 
		{
			this.status = status;
			borderHeight = scale * 5;
			borderWidth = scale * 12;
			
			drawOutline();
			drawStatus();
			
			addChild(statusBur);
			
			statusBur.mouseChildren = false;
			statusBur.mouseEnabled = false;
			
			switchBur()
		}
		
		public function switchBur():void
		{
			status = !status;
			
			var animationTime:Number = 1;
			var endX:Number = 0;
			
			if (status)
			{
				animationTime = statusBur.x/100;
			}
			else
			{
				endX = statusBur.width + 2
				animationTime = (statusBur.width + 2 - statusBur.x)/100;
			}
			
			TweenLite.to(statusBur, animationTime, { x:endX, ease:Strong.easeOut } );
		}
		
		private function drawStatus():void 
		{
			
			statusBur.graphics.beginFill(0xFFFFFF);
			statusBur.graphics.drawRect(1, 1, borderWidth/2-2, borderHeight-2);
		}
		
		private function drawOutline():void
		{
			this.graphics.beginFill(0x333333);
			this.graphics.lineStyle(2, 0x888888, 1, true, 'noScale', 'round');
			this.graphics.drawRect(0, 0, borderWidth, borderHeight);
		}
		
	}

}