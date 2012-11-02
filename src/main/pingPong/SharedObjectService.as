package pingPong 
{
	import flash.net.SharedObject;
	import ui.scoreboard.Scoreboard;
	/**
	 * ...
	 * @author Nikro
	 */
	public class SharedObjectService 
	{
		private var scoreBoard:Scoreboard;
		private var shared:SharedObject;
		public var localScore:Number = 0;
		
		public function SharedObjectService(scoreBoard:Scoreboard) 
		{
			this.scoreBoard = scoreBoard;
			initilize();
		}
		
		private function initilize():void 
		{
			shared = SharedObject.getLocal("pingPong9000");
			
			checkScore();
		}
		
		private function checkScore():void 
		{
			var sharedScore:Number = shared.data.score;
			
			if (sharedScore && !isNaN(sharedScore))
				localScore = sharedScore;
		
				
			scoreBoard.scores = localScore;
		}
		
		public function updateScore(value:Number):void
		{
			localScore = value;
			scoreBoard.scores = localScore;
			
			shared.data.score =  value;
			shared.flush();
		}
		
	}

}