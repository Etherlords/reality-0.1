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
			var force:Number = delta / 65;
			
			
			
			//if (Math.abs(force) < 0.7)
			//	return;
			
			//if (mouseX == 1)
			//	force = -1 * MOUS_OUT_FORCE;
			//else
			//if (mouseX > 795)
			//	force = MOUS_OUT_FORCE;
				
			rabbit.applyMove(force);
		}
	}
}
