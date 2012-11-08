package core.view.gameobject.body.constructor 
{
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import core.GlobalConstants;
import core.locators.PhysicWorldLocator;
import core.view.gameobject.body.IBodyPresentation;
import core.view.gameobject.body.PhysicBodyPresentation;
import core.view.skin.Skin;



/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyConstructor  implements IBodyConstructor
	{
		private var type:uint;
		private var shapeType:uint;

		public function PhysicBodyConstructor(type:uint, shapeType:uint) 
		{
			this.shapeType = shapeType;
			this.type = type;
			
		}
		
		/**
		 * Пока что шейп будет создаватся просто как прямоугольник по баунд боксу скина
		 * В случае надобности можно сделать более сложный конструктор для шейпов
		 * @return
		 */
		private function makeShapeFromSkin(skin:Skin):b2Shape
		{
			
			
			var width:Number = skin.phsyWidth * GlobalConstants.PIXELS_TO_METR;
			var height:Number = skin.phsyHeight * GlobalConstants.PIXELS_TO_METR;
			
			var shape:b2Shape
			
			
			if (shapeType == 0)
			{
				shape = new b2PolygonShape();
				//var shape:b2CircleShape = new b2CircleShape(30*GlobalConstants.PIXELS_TO_METR);
				
				
				(shape as b2PolygonShape).SetAsArray([new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)]);
			}
			else if(shapeType == 1)
			{
				shape = new b2CircleShape((width) / 2);
				//(shape as b2CircleShape).SetLocalPosition(new b2Vec2(width / 2, height / 2));
			}
			else if (shapeType == 2)
			{
				shape = new b2PolygonShape();
				(shape as b2PolygonShape).SetAsBox(width, height);
			}
			return shape;
		}
		
		/**
		 * Функция создает и возвращает представления боди
		 * Так же передает в представление скин тем самым связывая его с боди
		 */
		public function make(skin:Skin):IBodyPresentation
		{
			var bodyModel:b2BodyDef = new b2BodyDef();
			bodyModel.type = type;
			//bodyModel.fixedRotation = config.fixedRotation;
			
			var fixtureModel:b2FixtureDef = new b2FixtureDef();
			
			fixtureModel.shape = makeShapeFromSkin(skin);
			
			//bodyModel.fixedRotation = true;
			//Коммит этих физических свойств можно сделать одним методом
			//Просто переберая поля создать список поелй длоя коммита и просто обходить его
			
			var body:b2Body = PhysicWorldLocator.instance.world.CreateBody(bodyModel);
			body.CreateFixture(fixtureModel);
		
			
			return new PhysicBodyPresentation(body, skin);
		}
		
	}

}