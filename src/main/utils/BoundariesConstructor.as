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
		
		public var floor:GameObject;
		
		private function createEdge(x:Number, y:Number, width:Number, height:Number, raotation:Number):void
		{
			var filter:b2FilterData;
			var bodyConfig:GameobjectConfig = new GameobjectConfig();
			bodyConfig.skinClass = FloorShape;
			var model:PhysicModel = new PhysicModel();
			
			var body_2:GameObject = worldController.constructGameObject(GameObject, bodyConfig, model, viewInstance);
			body_2.body.x = x;
			body_2.body.y = y;
			body_2.body.rotation = raotation;
			//body_2.body.width = width;
			
			var fix:b2Fixture = (body_2.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
			filter = new b2FilterData();
			//filter.maskBits = 0x0004;
			filter.categoryBits = 4;
			fix.SetFilterData(filter);
			
			return;
			
			x *= GlobalConstants.PIXELS_TO_METR ;
			y *= GlobalConstants.PIXELS_TO_METR ;
			width *= GlobalConstants.PIXELS_TO_METR ;
			height *= GlobalConstants.PIXELS_TO_METR ;
			raotation *= GlobalConstants.DEGREE_TO_RAD ;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x, y);
			bodyDef.angle = raotation;
			bodyDef.allowSleep = true;
			bodyDef.awake = false;
			bodyDef.active = true;
			
			
			var body:b2Body = PhysicWorldLocator.instance.world.CreateBody(bodyDef);
			
			var shape:b2PolygonShape = new b2PolygonShape//(new b2Vec2(0, 0), new b2Vec2(width, height));
			shape.SetAsBox(width / 2, height / 2);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			
			fixtureDef.density = 1;
			fixtureDef.friction = 0;
			fixtureDef.restitution = 0;
			
		
			
			fixtureDef.shape = shape;
			var fixture:b2Fixture = body.CreateFixture(fixtureDef);
			
			filter = new b2FilterData();
			//filter.maskBits = 0x0004;
			filter.groupIndex = 1;
			filter.categoryBits = 6;
			fixture.SetFilterData(filter);
		
			
		}
		
		public function createBoundaries(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController):void
		{
			this.worldController = worldController;
			var i:int;
			this.viewInstance = viewInstance;
			
			var wallHeight:Number = 78000 * GlobalConstants.PIXELS_TO_METR;
			var wallWidth:Number = 1 * GlobalConstants.PIXELS_TO_METR;
			
			
			var floorConfig:GameobjectConfig = new GameobjectConfig();
			floorConfig.skinClass = FloorShape;
			
			floor = worldController.constructGameObject(Rabbit, floorConfig, new PhysicModel(), viewInstance);
			floor.body.y = _height * 2;
			
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
			var rightWallShape:b2EdgeShape = new b2EdgeShape(new b2Vec2(0, 0), new b2Vec2(0, wallHeight));
			
			//rightWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, 78000 * GlobalConstants.PIXELS_TO_METR);
			//rightWallShape.SetAsArray([new b2Vec2(0, 0), new b2Vec2(wallWidth, 0), new b2Vec2(wallWidth, wallHeight), new b2Vec2(0, wallHeight)]);
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