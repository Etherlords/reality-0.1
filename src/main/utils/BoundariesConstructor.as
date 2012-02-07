package utils 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	/**
	 * ...
	 * @author 
	 */
	public class BoundariesConstructor 
	{
		private var _width:Number = 800;
		private var _height:Number = 600;
		
		public function createBoundaries():void
		{
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.position.Set(0, _height * GlobalConstants.PIXELS_TO_METR);
			var groundBody:b2Body = PhysicWorldLocator.instance.world.CreateBody(groundBodyDef);
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(_width * GlobalConstants.PIXELS_TO_METR, 1 * GlobalConstants.PIXELS_TO_METR);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;
			var groundFixture:b2Fixture = groundBody.CreateFixture(groundFixtureDef);
			
			var rightWallBodyDef:b2BodyDef = new b2BodyDef();
			rightWallBodyDef.position.Set(_width * GlobalConstants.PIXELS_TO_METR, 0);
			var rightWallBody:b2Body = PhysicWorldLocator.instance.world.CreateBody(rightWallBodyDef);
			var rightWallShape:b2PolygonShape = new b2PolygonShape();
			rightWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, _height * GlobalConstants.PIXELS_TO_METR);
			var rightWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			rightWallFixtureDef.shape = rightWallShape;
			var rightWallFixture:b2Fixture = rightWallBody.CreateFixture(rightWallFixtureDef);
			
			var leftWallBodyDef:b2BodyDef = new b2BodyDef();
			leftWallBodyDef.position.Set(0, 0);
			var leftWallBody:b2Body = PhysicWorldLocator.instance.world.CreateBody(leftWallBodyDef);
			var leftWallShape:b2PolygonShape = new b2PolygonShape();
			leftWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, _height * GlobalConstants.PIXELS_TO_METR);
			var leftWallFixtureDef:b2FixtureDef = new b2FixtureDef();
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