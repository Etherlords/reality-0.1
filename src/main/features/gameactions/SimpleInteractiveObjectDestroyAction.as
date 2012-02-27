package features.gameactions 
{
	import core.locators.ServicesLocator;
	import patterns.strategy.Strategy;
	import ui.services.scores.ScoresService;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleInteractiveObjectDestroyAction extends Strategy 
	{
		private var scoresService:ScoresService;
		public function SimpleInteractiveObjectDestroyAction() 
		{
			super('SimpleInteractiveObjectDestroyAction', doAction);

			scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
		}
		
		public function doAction():void
		{
			scoresService.scoresSubstractor += 10;
            scoresService.scores += scoresService.scoresSubstractor;
		}
		
	}

}