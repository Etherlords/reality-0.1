package ui.rabbit.rabbitReactions 
{
import core.GlobalConstants;

import flash.display.Stage;

import patterns.strategy.Strategy;
import patterns.strategy.StrategyController;

import ui.rabbit.Rabbit;

/**
	 * ...
	 * @author 
	 */
	public class RabbitReactionsHelper 
	{
		public var behaviorStrategyController:StrategyController;
		
		private var rabbit:Rabbit;
		private var stage:Stage;
		
		public function RabbitReactionsHelper(rabbit:Rabbit, stage:Stage)
		{
			this.stage = stage;
			this.rabbit = rabbit;
			initilizeRabbitBehaviors();
		}
		
		public function rabbitAccelerateReaction():void 
		{
			rabbitAction(GlobalConstants.ACTION_STRATEGY_ACCELERATE);
		}

		public function flapWingsReaction():void 
		{
			rabbitAction(GlobalConstants.ACTION_STRATEGY_FLAP_WINGS);
		}
		
		public function rabbitMove(direction:Number):void
		{
			rabbitAction(GlobalConstants.ACTION_MOVE, direction);
		}
		
		public function calculateObjectMoving():void 
		{
			rabbitAction(GlobalConstants.ACTION_STRATEGY_FOLLOW_MOUSE);
		}

		public function jumpAction():void 
		{
			rabbitAction(GlobalConstants.ACTION_STRATEGY_JUMP, 10);
		}

		public function rabbitAction(key:String, ...rest):void 
		{
			rest.unshift(rabbit);

			behaviorStrategyController.execute(key, rest);
		}
		
		private function initilize():void
		{
			initilizeRabbitBehaviors();
		}
		
		private function initilizeRabbitBehaviors():void 
		{
			behaviorStrategyController = new StrategyController();
			
			var standarJump:Strategy = new Strategy(GlobalConstants.ACTION_STRATEGY_JUMP, new RabbitStandarJump());
			var followMouse:Strategy = new Strategy(GlobalConstants.ACTION_STRATEGY_FOLLOW_MOUSE, new RabbitFlowMouse(stage));
			var move:Strategy = new Strategy(GlobalConstants.ACTION_MOVE, new RabbitMove());
			
			behaviorStrategyController.addStrategy(standarJump);
			behaviorStrategyController.addStrategy(followMouse);
			behaviorStrategyController.addStrategy(move);
			behaviorStrategyController.addStrategy(new Strategy(GlobalConstants.ACTION_STRATEGY_ACCELERATE, new RabbitAccelerate()));
		}
		
	}

}