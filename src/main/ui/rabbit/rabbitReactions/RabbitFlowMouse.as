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

		private var stage:Stage;

		public function RabbitFlowMouse(aStage:Stage) 
		{
			stage = aStage;
		}

		public function execute(rabbit:Rabbit):void
		{
			var mouseX:Number = stage.mouseX;
			var rabbitX:Number = rabbit.body.x;
			var delta:Number = mouseX - rabbitX;
			var force:Number = delta / 20;

			rabbit.applyMove(force);
		}
	}
}
