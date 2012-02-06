/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 7:59
 */
package core.view.gameobject {
import core.view.gameobject.config.GameobjectConfig;

import flash.display.Sprite;
import flash.events.IEventDispatcher;

public class LifeTimeGameObject extends GameObject {
    
    private var _lifeTime:uint;
    private var _lastPreRenderCallTime:Date;
    
    public function LifeTimeGameObject(config:GameobjectConfig, skinHolderInstance:Sprite, eventFlowTarget:IEventDispatcher = null) {
        super(config, skinHolderInstance, eventFlowTarget);
    }


    override protected function initilize():void {
        super.initilize();
        _lifeTime = 0;
    }


    override public function preRender():void {
        super.preRender();
        if (_lastPreRenderCallTime) {
            var currentTime:Date = new Date();
            _lifeTime =  _lastPreRenderCallTime.getTime();
        }

    }
}
}
