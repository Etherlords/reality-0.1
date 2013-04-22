package ui.scoreboard 
{
	
	import feathers.controls.Label;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScoreboardStarling extends Sprite 
	{
		private var _scoresView:Label;
		
		private var _scores:Number = 0;
		
		public function ScoreboardStarling() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			_scoresView = new Label();
			_scoresView.height = 26;
			
			//_scoresView.y = 10;
			//_scoresView.x = 10;
			//_scoresView.autoScale = true
			//_scoresView.border = true;
			//_scoresView.x = -_scoresView.textBounds.x
			addChild(_scoresView);
			
			_scoresView.addEventListener(Event.ADDED_TO_STAGE, onAdded)
		}
		
		private function onAdded(e:Event):void 
		{
			_scoresView.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		public function set value(value:String):void
		{
			_scoresView.text = value;
			
			
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
			
			
		}
		
	}

}