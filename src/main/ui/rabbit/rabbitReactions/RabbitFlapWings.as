/**
 * author: chaos-encoder
 * Date: 05.02.12 Time: 19:41
 */
package ui.rabbit.rabbitReactions {
import core.GlobalConstants;

import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.Rabbit;

public class RabbitFlapWings extends SimpleAlgorithm {
    public function RabbitFlapWings() {
        super();
    }

    public function execute(rabbit:Rabbit):void
    {
        if (!rabbit.isLevitation()) { //todo remove quickfix
            return;
        }
        rabbit.physicalProperties.applyImpulse(0, -15);
        rabbit.applyActionView(GlobalConstants.ACTION_VIEW_FLAP_WINGS);
    }
}
}
