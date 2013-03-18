package ui.scoreboard 
{
	
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
		
		private function initilize():void 
		{
			_scoresView = new TextField(50, 20, '0', 'mini', 20, 0xFFFFFF);
			
			_scoresView.y = 10;
			_scoresView.x = 10;
			_scoresView.autoScale = true
			
			
			addChild(_scoresView);
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
			
			_scoresView.text = value.toString();
		}
		
	}

}