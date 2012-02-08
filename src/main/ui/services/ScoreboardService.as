package ui.services 
{
	import core.services.AbstractService;
	import ui.scoreboard.Scoreboard;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScoreboardService extends AbstractService 
	{
		private var _scoreboard:Scoreboard;
		
		public function ScoreboardService() 
		{
			super();
			
		}
		
		
		
		public function get scoreboard():Scoreboard 
		{
			return _scoreboard;
		}
		
		public function set scoreboard(value:Scoreboard):void 
		{
			_scoreboard = value;
		}
		
	}

}