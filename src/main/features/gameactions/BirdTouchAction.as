package features.gameactions 
{
	import core.locators.ServicesLocator;
	import patterns.strategy.Strategy;
	import ui.services.scores.ScoresService;
	
	/**
	 * ...
	 * @author 
	 */
	public class BirdTouchAction extends Strategy 
	{
		private var scoresService:ScoresService;
		public function BirdTouchAction() 
		{
			super('SimpleInteractiveObjectDestroyAction', doAction);
			scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
		}
		
		public function doAction():void
		{
			scoresService.scoresSubstractor += 50;
            scoresService.scores += scoresService.scoresSubstractor;
		}
		
	}

}