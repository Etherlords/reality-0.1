package ui 
{
	/**
	 * ...
	 * @author 
	 */
	public class Lables 
	{
		
		public static var GAME_OVER:String = '<font size="30">GAME OVER</font>'
												+ '\n\n\n\n'
												+ '<header>Your score</header>'
												+ '\n\n\n\n'
												+ '<scores>%score%</scores>'
												+ '\n\n\n\n'
												+ '<header>Your highest score</header>'
												+ '\n\n\n\n'
												+ '<scores>%highScore%</scores>'
												+ '\n\n\n\n'
												+ '<button><a href="event:playAgain">Play again?</a></button>'
												
		public static function getGAME_OVER_LABLE(score:Number, highestScore:Number):String
		{
			return GAME_OVER.split('%score%').join(score).split('%highScore%').join(highestScore);
		}
		
		public static var START_SCREEN:String = 	'<font size="35">MILK THE COW!</font>\n\n\n'
												+	'\n'
												+	'click on the cows as fast as u can'
												+	'\n'
												+	"until you've filled up your bucket "
												+	'\n\n\n'
												+	'<button><a href="event:startGame">Start the game</a></button>'
												+	'\n\n\n\n\n\n'

												+	'Copytights blablabla c()'
		
	}

}