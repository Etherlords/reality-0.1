package ui.rabbit 
{
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;

/**
	 * ...
	 * @author 
	 */
	public class Rabbit extends GameObject 
	{
		//public var movementFlag:
		
		public function Rabbit(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) 
		{
			super(config, physicModel, instance, eventFlowTarget);
			
			
		}

        override public function preRender(lastPreRenderCallDelay:uint):void
		{
            super.preRender(lastPreRenderCallDelay);
			applyActionView(0); //todo quickfix
        }
    }

}