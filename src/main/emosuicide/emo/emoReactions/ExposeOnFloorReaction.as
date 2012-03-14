/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:59
 */
package emosuicide.emo.emoReactions {
import core.GlobalConstants;

import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.Rabbit;

public class ExposeOnFloorReaction extends SimpleAlgorithm {
    public function ExposeOnFloorReaction() {
        super();
    }

    public function execute(rabbit:Rabbit):void {
        if (rabbit.physicalProperties.physicModel.linearVelocity.y > 8) {
            rabbit.applyActionView(GlobalConstants.ACTION_VIEW_EXPOSE_ON_FLOOR);
        }

    }
}
}
