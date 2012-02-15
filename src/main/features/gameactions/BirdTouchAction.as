package features.gameactions 
{
	import core.locators.ServicesLocator;
	import patterns.strategy.Strategy;
	
	/**
	 * ...
	 * @author 
	 */
	public class BirdTouchAction extends Strategy 
	{
		
		public function BirdTouchAction() 
		{
			super('SimpleInteractiveObjectDestroyAction', doAction);
		}
		
		public function doAction():void
		{
			ServicesLocator.scoreboardService.scoreboard.scores += 50;
		}
		
	}

}