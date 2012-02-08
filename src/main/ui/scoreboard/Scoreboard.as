package ui.scoreboard 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class Scoreboard extends Sprite 
	{
		private var _scoresView:TextField;
		
		private var _scores:Number = 0;
		
		public function Scoreboard() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			_scoresView = new TextField();
			
			_scoresView.y = 10;
			_scoresView.x = 10;
			_scoresView.autoSize = TextFieldAutoSize.LEFT;
			_scoresView.defaultTextFormat = new TextFormat("Verdana", 20, 0xFFFFFF);
			_scoresView.text = '0';
			
			addChild(_scoresView);
		}
		
		public function get scores():Number 
		{
			return _scores;
		}
		
		public function set scores(value:Number):void 
		{
			_scores = value;
			
			_scoresView.text = value.toString();
		}
		
	}

}