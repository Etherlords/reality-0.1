/**
 * author: chaos-encoder
 * Date: 04.02.12 Time: 6:34
 */
package ui.rabbit.rabbitReactions
{
import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.Rabbit;

public class RabbitAccelerate extends SimpleAlgorithm
	{
      

		public function RabbitAccelerate() {
			super();
           
		}

		public function execute(rabbit:Rabbit):void 
		{
			var linearVelocity:Point = rabbit.physicalProperties.physicModel.linearVelocity
			linearVelocity.y = 0;
			
			rabbit.physicalProperties.physicModel.linearVelocity = linearVelocity;
				
			rabbit.physicalProperties.applyImpulse(0, -10);

			
            //sceneView.scoresView.scores += scoresSubstractor;
            
			
		}
	}
}
