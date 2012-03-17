/**
 * author: chaos-encoder
 * Date: 02.02.12 Time: 18:47
 */
package ui.rabbit.rabbitReactions
{
import core.view.gameobject.GameObject;

import flash.display.Stage;
import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

public class RabbitFlowMouse extends SimpleAlgorithm
	
	{
		
		private static const MOUS_OUT_FORCE:Number = 8;

		private var stage:Stage;

		public function RabbitFlowMouse(aStage:Stage) 
		{
			stage = aStage;
		}

		public function execute(player:GameObject):void
		{
			var mouseX:Number = stage.mouseX;
			var rabbitX:Number = player.body.x + player.body.width / 2;
			var delta:Number = mouseX - rabbitX;
			
			var moveDirection:int;
			
			if (mouseX < rabbitX)
				moveDirection = -1;
			else
				moveDirection = 1;
				
				
			var force:Number;
			
			if (!(Math.abs(delta) < player.body.width / 2))
			{
				if (!player.direction.isWalking)
					force = delta / 20;
				else
				{	
					force = 4 * moveDirection;
				}
			}
			else
				force = 0;





            var linearVelocity:Point = player.physicalProperties.physicModel.linearVelocity;
            linearVelocity.x /= 6.5;
            linearVelocity.x += force;
            player.physicalProperties.physicBodyKey.SetAwake(true);
            player.physicalProperties.physicModel.linearVelocity = linearVelocity;
		}
	}
}