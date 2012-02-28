/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 7:59
 */
package core.view.lifetimeobject {
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.GameObject;

import flash.display.Sprite;
import flash.events.IEventDispatcher;

public class LifeTimeGameObject extends GameObject 
{
    
    private var _lifeTime:uint = 0;
    private var _lastLifeRecalTime:Date;
    
    public function LifeTimeGameObject(config:GameobjectConfig, skinHolderInstance:Sprite, eventFlowTarget:IEventDispatcher = null) 
	{
        super(config, skinHolderInstance, eventFlowTarget);
    }


    override protected function initilize():void 
	{
        super.initilize();
    }


    override public function preRender(lastPreRenderCallDelay:uint):void 
	{
        super.preRender(lastPreRenderCallDelay);
        addLife(lastPreRenderCallDelay);
    }

    protected function addLife(time:uint):void 
	{
        _lifeTime += time;
    }

    public function get lifeTime():Number 
	{
        return _lifeTime;
    }

    protected function resetLifeTime():void 
	{
        _lifeTime = 0;
    }
}
}
