/**
 * author: chaos-encoder
 * Date: 04.02.12 Time: 6:34
 */
package ui.rabbit.rabbitReactions {
import patterns.strategy.SimpleAlgorithm;

import ui.rabbit.Rabbit;

public class RabbitAccelerate extends SimpleAlgorithm {
    public function RabbitAccelerate() {
        super();
    }

    public function execute(rabbit:Rabbit):void {
        rabbit.physicalProperties.applyImpulse(0, -5);
    }
}
}
