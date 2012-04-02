/**
 * author: chaos-encoder
 * Date: 22.03.12 Time: 21:53
 */
package ragevagon.player {
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;

import ragevagon.weapon.Weapon;

public class RagePlayer extends GameObject {

    private var _weapon:Weapon;

    function RagePlayer(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) {
        super(config, physicModel, instance, eventFlowTarget);
    }

    override public function preRender(lastPreRenderCallDelay:uint):void
    {
        super.preRender(lastPreRenderCallDelay);
        applyActionView(0); //todo quickfix
    }

    public function get weapon():Weapon {
        return _weapon;
    }

    public function set weapon(value:Weapon):void {
        _weapon = value;
    }
}


}

