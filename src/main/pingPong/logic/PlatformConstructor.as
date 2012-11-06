package pingPong.logic 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	import pingPong.view.gameObjectsSkins.PlatformSkin;
	import starling.display.DisplayObjectContainer;
	import core.view.gameobject.GameObject;
	import ui.rabbit.constructor.PlayerConstructor;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlatformConstructor extends PlayerConstructor 
	{
		
		public function PlatformConstructor() 
		{
			
		}
		
		override public function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject 
		{
			var config:GameobjectConfig = new GameobjectConfig(true);
			//rabbitConfig.physicConfiguration.friction = 1;
			config.type = 2; //todo replace
			//config.shapeType = 1; //todo replace
			config.skinClass = PlatformSkin;
			
			var gameObject:GameObject = worldController.constructGameObject(GameObject, config, new PhysicModel(40, 1, 0.1),  stage);
			gameObject.physicalProperties.physicModel.fixedRotation = true;
			
			var body:b2Body = (gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey
			
			var fix:b2Fixture = body.GetFixtureList();
			fix.SetRestitution(1);
			fix.SetFriction(0);
			
			body.SetSleepingAllowed(false);
			
			return gameObject;
		}
		
	}

}