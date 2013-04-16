package ui.scoreboard 
{
	
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScoreboardStarling extends Sprite 
	{
		private var _scoresView:TextField;
		
		private var _scores:Number = 0;
		
		public function ScoreboardStarling() 
		{
			initilize();
		}
		
		public function getTextBoudns():Rectangle
		{
			return _scoresView.textBounds;
		}
		
		private function initilize():void 
		{
			_scoresView = new TextField(150, 50, '0', 'a_LCDNova', 40, 0xFFFFFF, true);
			
			//_scoresView.y = 10;
			//_scoresView.x = 10;
			//_scoresView.autoScale = true
			//_scoresView.border = true;
			//_scoresView.x = -_scoresView.textBounds.x
			addChild(_scoresView);
			
			flatten();
		}
		
		
		public function align():void
		{
			_scoresView.x = -_scoresView.textBounds.x
		}
		
		public function set value(value:String):void
		{
			_scoresView.text = value;
			
			flatten();
		}

		public function get scores():Number 
		{
			return _scores;
		}
		
		
		public function set scores(value:Number):void 
		{
            if (_scores == value) {
                return;
            }
				
			_scores = value;
			
			var t:String = value.toString();
			if (t.indexOf('.') != -1)
				t = t.substr(0, t.indexOf('.') + 3);
				
			_scoresView.text = t;
			
			//align();
			
			flatten();
		}
		
	}

}