/**
 * author: chaos-encoder
 * Date: 02.02.12 Time: 18:47
 */
package ui.rabbit.rabbitReactions
{
	import flash.display.Stage;
	import flash.geom.Point;

	import patterns.strategy.IAlgorithm;
	import patterns.strategy.SimpleAlgorithm;

	import ui.rabbit.Rabbit;

	public class RabbitMove extends SimpleAlgorithm                                                    
	{
		private var speed:Number = 5;
		
		public function RabbitMove() 
		{
		}

		public function execute(rabbit:Rabbit, direction:Number):void
		{	
			
			
			var linearVelocity:Point = rabbit.physicalProperties.physicModel.linearVelocity;
			linearVelocity.x = speed * direction;
			
			
			
			rabbit.physicalProperties.physicModel.linearVelocity = linearVelocity;
			
	
		}
	}
}