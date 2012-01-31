package ui.rabbit.rabbitReactions 
{
	import Box2D.Common.Math.b2Vec2;
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
			
			var linearVelocity:b2Vec2 = rabbit.physicalProperties.linearVelocity
			linearVelocity.Set(linearVelocity.x, 0);
			
			rabbit.applyImpulseFromCenter(new b2Vec2(0, -jumpForce));
		}
		
	}

}