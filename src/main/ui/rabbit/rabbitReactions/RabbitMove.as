/**
 * author: chaos-encoder
 * Date: 02.02.12 Time: 18:47
 */
package ui.rabbit.rabbitReactions
{
import core.view.gameobject.GameObject;

import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

public class RabbitMove extends SimpleAlgorithm
	{
		private var speed:Number = 5;
		
		public function RabbitMove() 
		{
		}

		public function execute(player:GameObject, direction:Number):void
		{	
			
			
			var linearVelocity:Point = player.physicalProperties.physicModel.linearVelocity;
			linearVelocity.x = speed * direction;



            player.physicalProperties.physicModel.linearVelocity = linearVelocity;
			
	
		}
	}
}