package mobiles 
{
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseMobile extends GameObject 
	{
		
		public function BaseMobile(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher=null) 
		{
			super(config, physicModel, instance, eventFlowTarget);
			
		}
		
		//so smart for u
		override public function render():void 
		{
			super.render();
			
			var linearVelocity:Point = physicalProperties.physicModel.linearVelocity
			linearVelocity.x = 1;//moveSpeed * moveDirection;
	
			
			physicalProperties.physicModel.linearVelocity = linearVelocity;
		}
		
	}

}