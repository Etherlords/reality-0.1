package ui.rabbit.constructor 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import ui.rabbit.Rabbit;
	import ui.rabbit.RabbitSkin;
	
	/**
	 * ...
	 * @author 
	 */
	public class RabbitConstructor extends PlayerConstructor
	{
		
		public function RabbitConstructor() 
		{
			
		}
		
		public override function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject
		{
			var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
			//rabbitConfig.physicConfiguration.friction = 1;
			rabbitConfig.type = 2; //todo replace
			rabbitConfig.skinClass = RabbitSkin;
			
			var gameObject:GameObject = worldController.constructGameObject(Rabbit, rabbitConfig, new PhysicModel(4, -1, 0.1),  stage);
			gameObject.physicalProperties.physicModel.fixedRotation = true;
			gameObject.body.x = 100;
			gameObject.body.y = 500 - gameObject.body.height;
			//gameObject.body.z = 100
			
			var body:b2Body = (gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey
			body.SetAngularDamping(500);
			var fix:b2Fixture = body.GetFixtureList();
			var filter:b2FilterData = new b2FilterData();
			filter.maskBits = 6;
			//filter.categoryBits = 0x0002;
			fix.SetFilterData(filter);
			
			body.SetSleepingAllowed(false);
			
			return gameObject;

		}
		
	}

}