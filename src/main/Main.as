package 
{
	
	import core.Box2D.utils.Box2DWorldConstructor;
	import core.Box2D.utils.PhysicBodyConstructor;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import flash.display.Sprite;
	import flash.geom.Point;	
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.b2Settings;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

import core.Box2D.utils.PhysicBodyConstructor;
import core.Box2D.utils.RabbitBodyConstructor;
import core.GlobalConstants;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;

import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import patterns.strategy.Strategy;
	import patterns.strategy.StrategyController;
	import ui.Bell;
	import ui.snow.FallingSnowAnimation;
	
	import ui.rabbit.Rabbit;
	import ui.rabbit.rabbitReactions.RabbitStandarJump;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var rabbit:Rabbit;
		public var world:b2World;

		public var stepTimer:Timer;
		

		
		private var bells:Vector.<Bell>
		private var bell:Bell;
		private var isHaveChanedBell:Boolean;
		private var rabbitReactions:StrategyController;
		private var fallingSnow:FallingSnowAnimation;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			fallingSnow = new FallingSnowAnimation(stage.stageWidth);
			addChild(fallingSnow);
			
			var gravity:b2Vec2 = new b2Vec2(0, 10);
			world = new b2World(gravity, true);
			PhysicWorldLocator.instance.world = world;
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GlobalConstants.PIXELS_TO_METR);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debugDraw);
			
			createBoundaries();
			

		
			rabbit = new Rabbit(new RabbitBodyConstructor(stage));

			
			bells = new Vector.<Bell>;
			
			createBell();
			createBell();
			createBell();
			createBell();
			createBell();
			createBell();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, jumpRabbit);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, calculateObjectMoving);
			
			var updateRabbitMoveTimer:Timer = new Timer(100);
			updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, calculateObjectMoving);
			updateRabbitMoveTimer.start();
			
			var bellCreationTimer:Timer = new Timer(1000);
			bellCreationTimer.addEventListener(TimerEvent.TIMER, createBell);
			bellCreationTimer.start();
			
			stepTimer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, onTick);
			graphics.lineStyle(3, 0xff0000);
			stepTimer.start();
			
			rabbitReactions = new StrategyController();
			var standarJump:Strategy = new Strategy('standartJump', new RabbitStandarJump());
			rabbitReactions.addStrategy(standarJump);
		}
		
		private function rabbitAction(key:String, ...rest):void
		{
			rest.unshift(rabbit);
			
			rabbitReactions.execute(key, rest);
		}
		
		private function calculateObjectMoving(e:* = null):void 
		{
			var mouseX:Number = stage.mouseX;
			
			var rabbitX:Number =  rabbit.dimensionalProperties.x;
			
			var delta:Number = mouseX - rabbitX;
			
			var force:Number = delta / 20;
			
			rabbit.applyMove(force);
		}
		
		private function jumpRabbit(e:MouseEvent):void 
		{
			if (rabbit.dimensionalProperties.y != 589)
				return;
			
			rabbitAction('standartJump', 10);
		}
		
		private function createBoundaries():void
		{
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.position.Set(0, stage.stageHeight * GlobalConstants.PIXELS_TO_METR);
			var groundBody:b2Body = world.CreateBody(groundBodyDef);
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(stage.stageWidth * GlobalConstants.PIXELS_TO_METR, 1 * GlobalConstants.PIXELS_TO_METR);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;
			var groundFixture:b2Fixture = groundBody.CreateFixture(groundFixtureDef);
			
			var rightWallBodyDef:b2BodyDef = new b2BodyDef();
			rightWallBodyDef.position.Set(stage.stageWidth * GlobalConstants.PIXELS_TO_METR, 0);
			var rightWallBody:b2Body = world.CreateBody(rightWallBodyDef);
			var rightWallShape:b2PolygonShape = new b2PolygonShape();
			rightWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, stage.stageHeight * GlobalConstants.PIXELS_TO_METR);
			var rightWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			rightWallFixtureDef.shape = rightWallShape;
			var rightWallFixture:b2Fixture = rightWallBody.CreateFixture(rightWallFixtureDef);
			
			var leftWallBodyDef:b2BodyDef = new b2BodyDef();
			leftWallBodyDef.position.Set(0, 0);
			var leftWallBody:b2Body = world.CreateBody(leftWallBodyDef);
			var leftWallShape:b2PolygonShape = new b2PolygonShape();
			leftWallShape.SetAsBox(1 * GlobalConstants.PIXELS_TO_METR, stage.stageHeight * GlobalConstants.PIXELS_TO_METR);
			var leftWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			leftWallFixtureDef.shape = leftWallShape;
			var leftWallFixture:b2Fixture = leftWallBody.CreateFixture(leftWallFixtureDef);
		}
		
		private function createBell(e:* = null):void
		{
            var config:GameobjectConfig = new GameobjectConfig(true);
            bell = new Bell(new PhysicBodyConstructor(config.physicConfiguration));
		}
		
		private function findCollesions():void
		{
			var markToDelete:Array = [];
			
			var bell:Bell;
			for (var i:int = 0; i < bells.length; i++)
			{
				
				bell = bells[i];
				
				if (bell.dimensionalProperties.y > rabbit.dimensionalProperties.y + stage.stageHeight / 2)
				{
					markToDelete.push(i);
					continue;
				}
				
				var p:Point = new Point(bell.dimensionalProperties.x, bell.dimensionalProperties.y);
				var p2:Point = new Point(rabbit.dimensionalProperties.x, rabbit.dimensionalProperties.y);
				
				if (Point.distance(p, p2) < 25)
				{
					createBell()
					rabbitAction('standartJump', 10);
					markToDelete.push(i);
				}
			}
			
			for (i = 0; i < markToDelete.length; i++)
			{
				bell = bells.splice(markToDelete[i], 1)[0];
				bell.destroy();
				bell = null;
			}
		}
		
		private function sorOnY(element1:GameObject, element2:GameObject):int
		{
			if (element1.dimensionalProperties.y > element2.dimensionalProperties.y)
				return 1;
			else
				return 0;
		}
		
		private function onTick(e:TimerEvent):void 
		{
			this.y = stage.stageHeight / 2 - rabbit.dimensionalProperties.y;
			
			if (this.y < 0)	
				this.y = 0;
				
			fallingSnow.drawingY = this.y;
			
			world.Step(0.04, 100, 100);
			world.DrawDebugData();
			
			findCollesions();
		}
		
	}
	
}