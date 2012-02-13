package features.gameactions 
{
	import core.locators.ServicesLocator;
	import patterns.strategy.Strategy;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleInteractiveObjectDestroyAction extends Strategy 
	{
		
		public function SimpleInteractiveObjectDestroyAction() 
		{
			super('SimpleInteractiveObjectDestroyAction', doAction);
		}
		
		public function doAction():void
		{
			ServicesLocator.scoreboardService.scoreboard.scores += 10;
		}
		
	}

}