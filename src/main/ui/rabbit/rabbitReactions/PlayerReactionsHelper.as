package ui.rabbit.rabbitReactions 
{
import core.GlobalConstants;
import core.view.gameobject.GameObject;

import flash.display.Stage;

import patterns.strategy.Strategy;
import patterns.strategy.StrategyController;

/**
	 * ...
	 * @author 
	 */
	public class PlayerReactionsHelper
	{
		public var behaviorStrategyController:StrategyController;
		
		private var player:GameObject;
		private var stage:Stage;
		
		public function PlayerReactionsHelper(player:GameObject, stage:Stage)
		{
			this.stage = stage;
			this.player = player;
			initilizeRabbitBehaviors();
		}
		
		public function accelerateReaction():void
		{
			doAction(GlobalConstants.ACTION_STRATEGY_ACCELERATE);
		}

		public function move(direction:Number):void
		{
			doAction(GlobalConstants.ACTION_MOVE, direction);
		}
		
		public function calculateObjectMoving():void 
		{
			doAction(GlobalConstants.ACTION_STRATEGY_FOLLOW_MOUSE);
		}

		public function jumpAction():void 
		{
			doAction(GlobalConstants.ACTION_STRATEGY_JUMP, 160);
		}

		public function doAction(key:String, ...rest):void
		{
			rest.unshift(player);

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