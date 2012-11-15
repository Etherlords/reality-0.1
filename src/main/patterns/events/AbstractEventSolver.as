package patterns.events 
{
	import patterns.strategy.StrategyController;
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractEventSolver 
	{
		protected var strategyController:StrategyController;
		/**
		 * Function should recive event as fitst argument
		 */
		protected var solver:Function;
		
		public function AbstractEventSolver(strategyController:StrategyController) 
		{
			this.strategyController = strategyController;
		}
		
		public function get eventSolverFunction():Function
		{
			return solver;
		}
		
	}

}