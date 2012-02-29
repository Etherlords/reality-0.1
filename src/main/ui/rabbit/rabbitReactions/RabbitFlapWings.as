/**
 * author: chaos-encoder
 * Date: 05.02.12 Time: 19:41
 */
package ui.rabbit.rabbitReactions {
import core.GlobalConstants;
import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.FlapTriggerGameObject;
import ui.rabbit.Rabbit;

public class RabbitFlapWings extends SimpleAlgorithm 
{

    private var  _flapTrigger:FlapTriggerGameObject;

    public function RabbitFlapWings(flapTrigger:FlapTriggerGameObject) 
	{
        super();
        _flapTrigger = flapTrigger;
    }

    public function execute(rabbit:Rabbit):void
    {
        if (!_flapTrigger.isAbleToFlap()) 
		{
            return;
        }
		
		var linearVelocity:Point = rabbit.physicalProperties.physicModel.linearVelocity
		linearVelocity.y = linearVelocity.y / 2;
		
		rabbit.physicalProperties.physicModel.linearVelocity = linearVelocity;
		
        _flapTrigger.flap();
        rabbit.physicalProperties.applyImpulse(0, -5);
        rabbit.applyActionView(GlobalConstants.ACTION_VIEW_FLAP_WINGS);
    }
}
}
