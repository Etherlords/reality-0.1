package ui.rabbit.rabbitReactions 
{
	import core.GlobalConstants;
	import patterns.strategy.SimpleAlgorithm;
	import ui.rabbit.Rabbit;
	
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
		
		public function execute(rabbit:Rabbit, jumpForce:Number):void
		{
			
			
			if (Math.abs(rabbit.physicalProperties.physicModel.linearVelocity.y) > 1)
				return;
			
			rabbit.physicalProperties.applyImpulse(0, -jumpForce);
			rabbit.applyActionView(GlobalConstants.ACTION_VIEW_JUMP_LEFT);
			//var linearVelocity:b2Vec2 = rabbit.physicalProperties.linearVelocity
			//linearVelocity.Set(linearVelocity.x, 0);
			
			//rabbit.applyImpulseFromCenter(new b2Vec2(0, -jumpForce));
		}
		
	}

}