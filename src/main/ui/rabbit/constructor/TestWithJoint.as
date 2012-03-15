package ui.rabbit.constructor 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import core.Box2D.utils.Box2DWorldController;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import ui.BaloonShape;
	import ui.rabbit.Rabbit;
	import ui.rabbit.RabbitSkin;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestWithJoint extends PlayerConstructor
	{
		
		public function TestWithJoint() 
		{
			
		}
		
		public override function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject
		{
			var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
			//rabbitConfig.physicConfiguration.friction = 1;
			rabbitConfig.type = 2; //todo replace
			rabbitConfig.skinClass = RabbitSkin;
			var rabbitModel:PhysicModel = new PhysicModel(1.5, 1, 1);
			rabbitModel.fixedRotation = false;
			var rabbit:GameObject = worldController.constructGameObject(Rabbit, rabbitConfig, rabbitModel,  stage);
			
			
			var baloonConfig:GameobjectConfig = new GameobjectConfig(true);
			
			baloonConfig.type = 2; //todo replace
			baloonConfig.skinClass = BaloonShape;
			var baloonModel:PhysicModel = new PhysicModel(2, 1, 1);
			baloonModel.fixedRotation = false;
			var baloon:GameObject = worldController.constructGameObject(GameObject, baloonConfig, baloonModel,  stage);
			
			
			rabbit.body.x = 350;
			rabbit.body.y = 500;
			baloon.body.x = 350;
			baloon.body.y = 500 - (baloon.body.height + 50);
			
			(baloon.physicalProperties as SimplePhysicalProperties).physicBodyKey.SetAngularDamping(35);
			(rabbit.physicalProperties as SimplePhysicalProperties).physicBodyKey.SetAngularDamping(35);
			
			
			var joint:b2DistanceJoint;
			var jointDef:b2DistanceJointDef = new b2DistanceJointDef();
			
			var m_physScale:Number = GlobalConstants.METRS_TO_PIXEL;
		
			
			var anchor1:b2Vec2 = new b2Vec2((baloon.body.x + baloon.body.width/2)/ m_physScale, (baloon.body.y + baloon.body.height/2) / m_physScale);
			var anchor2:b2Vec2 = new b2Vec2((rabbit.body.x + rabbit.body.width/2)/ m_physScale, (rabbit.body.y + rabbit.body.height/2) / m_physScale);
			
			worldController.getController('nullGravityField').AddBody((baloon.physicalProperties as SimplePhysicalProperties).physicBodyKey);
			
			jointDef.Initialize((baloon.physicalProperties as SimplePhysicalProperties).physicBodyKey, (rabbit.physicalProperties as SimplePhysicalProperties).physicBodyKey, anchor1, anchor2);
			jointDef.frequencyHz = 1;
			jointDef.length = 4;
			jointDef.dampingRatio = 0.1;
			
			
			//m_joint1 = m_world.CreateJoint(pulleyDef) as b2PulleyJoint;
			joint = PhysicWorldLocator.instance.world.CreateJoint(jointDef) as b2DistanceJoint;
			
			anchor1.x -= baloon.body.width / 2 / m_physScale;
			anchor2.x -= 8 / m_physScale;
			
			jointDef.Initialize((baloon.physicalProperties as SimplePhysicalProperties).physicBodyKey, (rabbit.physicalProperties as SimplePhysicalProperties).physicBodyKey, anchor1, anchor2);
			jointDef.frequencyHz = 2;
			jointDef.length = 3.5;
			jointDef.dampingRatio = 1;
			
			PhysicWorldLocator.instance.world.CreateJoint(jointDef);
			
			anchor1.x += baloon.body.width  / m_physScale;
			anchor2.x += 16/m_physScale;
			jointDef.Initialize((baloon.physicalProperties as SimplePhysicalProperties).physicBodyKey, (rabbit.physicalProperties as SimplePhysicalProperties).physicBodyKey, anchor1, anchor2);
			jointDef.frequencyHz = 2;
			jointDef.length = 3.5;
			jointDef.dampingRatio = 1;
			
			PhysicWorldLocator.instance.world.CreateJoint(jointDef);
			
			
			return rabbit;

		}
		
	}

}