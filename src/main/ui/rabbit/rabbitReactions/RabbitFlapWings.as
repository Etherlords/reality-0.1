/**
 * author: chaos-encoder
 * Date: 05.02.12 Time: 19:41
 */
package ui.rabbit.rabbitReactions {
import core.GlobalConstants;
import core.view.gameobject.GameObject;

import flash.geom.Point;

import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.FlapTriggerGameObject;

public class RabbitFlapWings extends SimpleAlgorithm
{

    private var  _flapTrigger:FlapTriggerGameObject;

    public function RabbitFlapWings(flapTrigger:FlapTriggerGameObject) 
	{
        super();
        _flapTrigger = flapTrigger;
    }

    public function execute(player:GameObject):void
    {
        if (!_flapTrigger.isAbleToFlap()) 
		{
            return;
        }
		
		var linearVelocity:Point = player.physicalProperties.physicModel.linearVelocity
		linearVelocity.y = linearVelocity.y / 2;

        player.physicalProperties.physicModel.linearVelocity = linearVelocity;
		
        _flapTrigger.flap();
        player.physicalProperties.applyImpulse(0, -5);
        player.applyActionView(GlobalConstants.ACTION_VIEW_FLAP_WINGS);
    }
}
}
