package ui.rabbit.rabbitReactions 
{
import core.GlobalConstants;
import core.view.gameobject.GameObject;

import patterns.strategy.SimpleAlgorithm;

/**
	 * ...
	 * @author 
	 */
	public class RabbitStandarJump extends SimpleAlgorithm 
	{
		
		public function RabbitStandarJump() 
		{
			super();
			
		}
		
		public function execute(player:GameObject, jumpForce:Number):void
		{
			
			
			if (Math.abs(player.physicalProperties.physicModel.linearVelocity.y) > 0.2)
				return;

            player.physicalProperties.applyImpulse(0, -jumpForce);
            player.applyActionView(GlobalConstants.ACTION_VIEW_JUMP_LEFT);
			//var linearVelocity:b2Vec2 = rabbit.physicalProperties.linearVelocity
			//linearVelocity.Set(linearVelocity.x, 0);
			
			//rabbit.applyImpulseFromCenter(new b2Vec2(0, -jumpForce));
		}
		
	}

}