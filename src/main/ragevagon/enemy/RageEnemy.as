/**
 * author: chaos-encoder
 * Date: 26.03.12 Time: 22:15
 */
package ragevagon.enemy {
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;

public class RageEnemy extends GameObject {
    public function RageEnemy(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) {
        super(config, physicModel, instance, eventFlowTarget);
    }


    override public function toString():String {
        return "[RageEnemy]";
    }
}
}
