/**
 * author: chaos-encoder
 * Date: 02.02.12 Time: 18:47
 */
package ui.rabbit.rabbitReactions
{
	import flash.display.Stage;

	import patterns.strategy.IAlgorithm;
	import patterns.strategy.SimpleAlgorithm;

	import ui.rabbit.Rabbit;

	public class RabbitFlowMouse extends SimpleAlgorithm                                                    
	
	{
		
		private static const MOUS_OUT_FORCE:Number = 8;

		private var stage:Stage;

		public function RabbitFlowMouse(aStage:Stage) 
		{
			stage = aStage;
		}

		public function execute(rabbit:Rabbit):void
		{
			var mouseX:Number = stage.mouseX;
			var rabbitX:Number = rabbit.body.x + rabbit.body.width / 2;
			var delta:Number = mouseX - rabbitX;
			
			var moveDirection:int;
			
			if (mouseX < rabbitX)
				moveDirection = -1;
			else
				moveDirection = 1;
				
				
			var force:Number;
			
			if (!(Math.abs(delta) < rabbit.body.width / 2))
			{
				if (!rabbit.direction.isWalking)
					force = delta / 20;
				else
				{	
					force = 4 * moveDirection;
				}
			}
			else
				force = 0;
				
			
			
			
			
				
			
				
			rabbit.applyMove(force);
		}
	}
}
