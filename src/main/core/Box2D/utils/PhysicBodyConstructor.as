package core.Box2D.utils 
{
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;

import core.GlobalConstants;
import core.body.IBodyPresentation;
import core.body.PhysicBodyPresentation;
import core.locators.PhysicWorldLocator;
import core.view.gameobject.config.PhysicConfiguration;
import core.view.skin.Skin;

/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyConstructor  implements BodyConstructor
	{
		private var config:PhysicConfiguration;
		
		public function PhysicBodyConstructor(config:PhysicConfiguration) 
		{
			this.config = config;
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
			
			var shape:b2PolygonShape = new b2PolygonShape();
			
			shape.SetAsArray([new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)]);
			
			return shape;
		}
		
		/**
		 * Функция создает и возвращает представления боди
		 * Так же передает в представление скин тем самым связывая его с боди
		 */
		public function make(skin:Skin):IBodyPresentation
		{
			var bodyModel:b2BodyDef = new b2BodyDef();
			bodyModel.type = config.type;
			bodyModel.fixedRotation = config.fixedRotation;
			
			var fixtureModel:b2FixtureDef = new b2FixtureDef();
			
			fixtureModel.shape = makeShapeFromSkin(skin);
			
			//Коммит этих физических свойств можно сделать одним методом
			//Просто переберая поля создать список поелй длоя коммита и просто обходить его
			
			if(config.density)
				fixtureModel.density = config.density;
			
			if(config.friction)
				fixtureModel.friction = config.friction;
			
			if(config.restitution)
				fixtureModel.restitution = config.restitution;
			
			var body:b2Body = PhysicWorldLocator.instance.world.CreateBody(bodyModel);
			body.CreateFixture(fixtureModel);
			
			return new PhysicBodyPresentation(body, skin);
		}
		
	}

}