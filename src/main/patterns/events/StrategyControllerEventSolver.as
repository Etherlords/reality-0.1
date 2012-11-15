package patterns.events 
{
	import core.net.events.ConnectionActivityEvent;
	import utils.getClassOfObject;
	import patterns.strategy.StrategyController;
	/**
	 * Solve event handle and redirect it to specifig strategy with a event type as token
	 * @author Nikro
	 */
	public class StrategyControllerEventSolver extends AbstractEventSolver 
	{
		
		
		public function StrategyControllerEventSolver(strategyController:StrategyController) 
		{
			super(strategyController);
			
			initilize();
		}	
		
		private function initilize():void 
		{
			solver = solveFunction
		}
		
		private function solveFunction(e:ConnectionActivityEvent):void
		{
			strategyController.execute(getClassOfObject(e.data), e.data);
		}
		
	}

}