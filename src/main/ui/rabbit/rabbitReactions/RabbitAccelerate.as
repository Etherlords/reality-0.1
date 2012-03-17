/**
 * author: chaos-encoder
 * Date: 04.02.12 Time: 6:34
 */
package ui.rabbit.rabbitReactions
{
import core.view.gameobject.GameObject;

import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

public class RabbitAccelerate extends SimpleAlgorithm
	{
      

		public function RabbitAccelerate() {
			super();
           
		}

		public function execute(player:GameObject):void
		{
			var linearVelocity:Point = player.physicalProperties.physicModel.linearVelocity
			linearVelocity.y = 0;

            player.physicalProperties.physicModel.linearVelocity = linearVelocity;

            player.physicalProperties.applyImpulse(0, -10);

			
            //sceneView.scoresView.scores += scoresSubstractor;
            
			
		}
	}
}
