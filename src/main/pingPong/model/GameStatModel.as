package pingPong.model 
{
	import patterns.LazyModerator;
	import patterns.Moderator;
	/**
	 * ...
	 * @author Nikro
	 */
	
	public class GameStatModel extends LazyModerator
	{
		
		private var _score:Number;
		private var _ricoshet:Number;
		private var _bollSpeed:Number;
		
		public function GameStatModel() 
		{
			
		}
		
		public function set score(value:Number):void 
		{
			_score = value;
			moderateField('score');
		}
		
		public function set ricoshet(value:Number):void 
		{
			_ricoshet = value;
			moderateField('ricoshet');
			
		}
		
		public function set bollSpeed(value:Number):void 
		{
			_bollSpeed = value;
			moderateField('bollSpeed');
		}
		
		public function get score():Number 
		{
			return _score;
		}
		
		public function get ricoshet():Number 
		{
			return _ricoshet;
		}
		
		public function get bollSpeed():Number 
		{
			return _bollSpeed;
		}
		
	}

}