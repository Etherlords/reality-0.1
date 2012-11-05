package utils 
{
	import Box2D.Collision.Shapes.b2EdgeShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import core.Box2D.utils.Box2DWorldController;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import ui.DetectorShape;
	import ui.FloorShape;
	import ui.rabbit.Rabbit;
	/**
	 * ...
	 * @author 
	 */
	public class BoundariesConstructor 
	{
		private var _width:Number = 760;
		private var _height:Number = 593;
		private var viewInstance:DisplayObjectContainer;
		private var worldController:Box2DWorldController;
		
		public var right:GameObject;
		public var left:GameObject;
		
		public var floor:GameObject;
		
		
		public function createBoundaries(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController):void
		{
			this.worldController = worldController;
			var i:int;
			this.viewInstance = viewInstance;
			
			var wallHeight:Number = 78000 * GlobalConstants.PIXELS_TO_METR;
			var wallWidth:Number = 1 * GlobalConstants.PIXELS_TO_METR;
			
			
			var wallConfig:GameobjectConfig = new GameobjectConfig();
			wallConfig.skinClass = FloorShape;
			
			floor = worldController.constructGameObject(GameObject, wallConfig, new PhysicModel(100, 0, 0), viewInstance);
			floor.body.y = 500
			floor.body.x = 0
			
			var body:b2Body = (floor.physicalProperties as SimplePhysicalProperties).physicBodyKey
			
			var fix:b2Fixture = body.GetFixtureList();
			fix.SetRestitution(1);
			fix.SetDensity(100);
			fix.SetFriction(0);
			
			var roof:GameObject = worldController.constructGameObject(GameObject, wallConfig, new PhysicModel(100, 0, 0), viewInstance);
			roof.body.y = 0;
			roof.body.y = 0;
			
			body = (roof.physicalProperties as SimplePhysicalProperties).physicBodyKey
			
			
			fix = body.GetFixtureList();
			fix.SetRestitution(1);
			fix.SetDensity(100);
			fix.SetFriction(0);
			
			wallConfig.skinClass = DetectorShape
			right = worldController.constructGameObject(GameObject, wallConfig, new PhysicModel(100, 0, 0), viewInstance);
			left = worldController.constructGameObject(GameObject, wallConfig, new PhysicModel(100, 0, 0), viewInstance);
			
			right.body.x = -20;
			
			left.body.x = 780;
			
			right.body.y = 10;
			left.body.y = 10;
		}

        public function get height():Number {
            return _height;
        }

        public function get width():Number {
            return _width;
        }
    }

}