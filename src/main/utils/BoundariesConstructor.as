package utils 
{
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
		
		public var floor:GameObject;
		
		public function createBoundaries(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController):void
		{
			this.viewInstance = viewInstance;
			
			var wallHeight:Number = 78000 * GlobalConstants.PIXELS_TO_METR;
			var wallWidth:Number = 1 * GlobalConstants.PIXELS_TO_METR;
			
			
			var floorConfig:GameobjectConfig = new GameobjectConfig();
			
			
			floorConfig.skinClass = FloorShape;
			
			

			floor = worldController.constructGameObject(Rabbit, floorConfig, new PhysicModel(), viewInstance);
			floor.body.y = _height;
			
			var fix:b2Fixture = (floor.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
			var filter:b2FilterData = new b2FilterData();
			//filter.maskBits = 0x0004;
			filter.categoryBits = 4;
			fix.SetFilterData(filter);
			
			//var roof:GameObject = worldController.constructGameObject(Rabbit, floorConfig, new PhysicModel(), viewInstance);
			//roof.body.y = 0;
		
			
			var rightWallBodyDef:b2BodyDef = new b2BodyDef();
			rightWallBodyDef.position.Set(_width * GlobalConstants.PIXELS_TO_METR, (- wallHeight + _height * GlobalConstants.PIXELS_TO_METR ) );
			var rightWallBody:b2Body = PhysicWorldLocator.instance.world.CreateBody(rightWallBodyDef);
			var rightWallShape:b2PolygonShape = new b2PolygonShape();
			//rightWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, 78000 * GlobalConstants.PIXELS_TO_METR);
			rightWallShape.SetAsArray([new b2Vec2(0, 0), new b2Vec2(wallWidth, 0), new b2Vec2(wallWidth, wallHeight), new b2Vec2(0, wallHeight)]);
			var rightWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			
			rightWallFixtureDef.density = 0;
			rightWallFixtureDef.friction = 0;
			rightWallFixtureDef.restitution = 0;
			
			rightWallFixtureDef.shape = rightWallShape;
			var rightWallFixture:b2Fixture = rightWallBody.CreateFixture(rightWallFixtureDef);
			
			var leftWallBodyDef:b2BodyDef = new b2BodyDef();
			leftWallBodyDef.position.Set(0, (- wallHeight + _height * GlobalConstants.PIXELS_TO_METR ));
			var leftWallBody:b2Body = PhysicWorldLocator.instance.world.CreateBody(leftWallBodyDef);
			var leftWallShape:b2PolygonShape = new b2PolygonShape();
			
			leftWallShape.SetAsArray([new b2Vec2(0, 0), new b2Vec2(wallWidth, 0), new b2Vec2(wallWidth, wallHeight), new b2Vec2(0, wallHeight)]);
			//leftWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, 78000 * GlobalConstants.PIXELS_TO_METR);
			var leftWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			
			leftWallFixtureDef.density = 0;
			leftWallFixtureDef.friction = 0;
			leftWallFixtureDef.restitution = 0;
			
			leftWallFixtureDef.shape = leftWallShape;
			var leftWallFixture:b2Fixture = leftWallBody.CreateFixture(leftWallFixtureDef);
		}

        public function get height():Number {
            return _height;
        }

        public function get width():Number {
            return _width;
        }
    }

}