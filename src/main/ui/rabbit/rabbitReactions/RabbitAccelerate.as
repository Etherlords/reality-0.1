/**
 * author: chaos-encoder
 * Date: 04.02.12 Time: 6:34
 */
package ui.rabbit.rabbitReactions
{
import core.locators.ServicesLocator;

import flash.geom.Point;
	import patterns.strategy.SimpleAlgorithm;

	import ui.rabbit.Rabbit;
import ui.services.scores.ScoresService;

public class RabbitAccelerate extends SimpleAlgorithm
	{
        private var scoresService:ScoresService;

		public function RabbitAccelerate() {
			super();
            scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
		}

		public function execute(rabbit:Rabbit):void 
		{
			var linearVelocity:Point = rabbit.physicalProperties.linearVelocity
			linearVelocity.y = 0;
			
			rabbit.physicalProperties.linearVelocity = linearVelocity;
			
			rabbit.resetFlyAnim();
				
			rabbit.physicalProperties.applyImpulse(0, -10);

            scoresService.scores += scoresService.scoresSubstractor;
            //sceneView.scoresView.scores += scoresSubstractor;
            scoresService.scoresSubstractor += 10;
			
		}
	}
}
