package ui.rabbit.logic 
{
import Box2D.Dynamics.b2FilterData;
import Box2D.Dynamics.b2Fixture;

import core.Box2D.utils.Box2DWorldController;
import core.events.GameObjectPhysicEvent;
import core.ui.KeyBoardController;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;
import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.utils.Timer;

import ui.BulletSkin;
import ui.gameobjects.BaseInteractiveGameObject;
import ui.rabbit.Rabbit;
import ui.rabbit.constructor.PlayerConstructor;
import ui.rabbit.rabbitReactions.RabbitReactionsHelper;

/**
	 * ...
	 * @author 
	 */
	public class RabbitControllerShooter 
	{
		private var viewInstance:DisplayObjectContainer;
		
		public var rabbitActionsHelper:RabbitReactionsHelper;
		private var _rabbit:Rabbit;
		private var worldController:Box2DWorldController;
		private var keyController:KeyBoardController;
		private var constructor:PlayerConstructor;
		
		public function RabbitControllerShooter(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, constructor:PlayerConstructor) 
		{
			this.constructor = constructor;
			this.worldController = worldController;
			this.viewInstance = viewInstance;
			
			keyController = new KeyBoardController(viewInstance.stage);
			
			initilize();
		}
		
		public function replay():void
		{
			viewInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, jumpAction);
		}
		
		public function gameOver():void
		{
			viewInstance.stage.removeEventListener(MouseEvent.MOUSE_DOWN, jumpAction);
		}
		
		private function initilize():void 
		{
			createRabbitView();
			manageOvertimeEvents();
			manageMouseEvents();
			manageRabbitEvents();
			
			keyController.registerKeyDownReaction(Keyboard.SPACE, tryFlap);
			
			keyController.registerKeyDownReaction(Keyboard.UP, jumpAction);
			
			keyController.registerKeyUpReaction(Keyboard.LEFT, stop);
			keyController.registerKeyUpReaction(Keyboard.RIGHT, stop);
		}
		
		private function stop():void 
		{
			
			var velocity:Point = rabbit.physicalProperties.physicModel.linearVelocity;
			velocity.x /= 3;
			rabbit.physicalProperties.physicModel.linearVelocity = velocity;
		}
		
		
		
		private function manageRabbitEvents():void 
		{
			
			rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, collideWithReaction);
		}
		
		private function manageMouseEvents():void 
		{
			viewInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, addBullet);
		}
		
		private function addBullet(e:MouseEvent):void 
		{
			var bulletConfig:GameobjectConfig = new GameobjectConfig();
			bulletConfig.shapeType = 1;
			bulletConfig.type = 2;
			bulletConfig.skinClass = BulletSkin;
			var bullet:GameObject = worldController.constructGameObject(GameObject, bulletConfig, new PhysicModel, viewInstance); 
			
			var fix:b2Fixture = (bullet.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
			var filter:b2FilterData = new b2FilterData();
			filter.maskBits = 6;
			fix.SetFilterData(filter);
			
			bullet.body.x = rabbit.body.x + rabbit.body.height / 2;
			bullet.body.y = rabbit.body.y + rabbit.body.height / 2;
			
			bullet.physicalProperties.applyImpulse((e.stageX - rabbit.body.x ) / 10, (e.stageY - rabbit.body.y)/ 10);
		}
		
		private function manageOvertimeEvents():void
		{
			var updateRabbitMoveTimer:Timer = new Timer(100);
			updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, rabbitMovieTime);
			updateRabbitMoveTimer.start();
		}

		private function rabbitMovieTime(e:TimerEvent):void
		{
			if (moving)
				rabbitActionsHelper.rabbitMove(direction);
		}

		private function jumpAction(e:* = null):void
		{
			rabbitActionsHelper.jumpAction();
		}
		
		private function tryFlap():void 
		{
			rabbitActionsHelper.jumpAction();
		}
		
		private function collideWithReaction(e:GameObjectPhysicEvent):void 
		{
			if (!(e.interactionWith is BaseInteractiveGameObject))
			{
				return;
			}
			
			rabbitActionsHelper.rabbitAccelerateReaction();
			

			/**
			 * Конечно не правильно тут объект уничтожать поидеи но когда понадабится дополнительное
			 * взаимоедсвтие можно будет еракцию вынести на контроллер выше стоящий или баблить туда
			 * ивенты
			 */
			(e.interactionWith as BaseInteractiveGameObject).interactiveObjectConfig.destructionAlgorithm.execute();
			worldController.destroyGameObject(e.interactionWith);
		}
		
		private function createRabbitView():void 
		{
			
			_rabbit = constructor.make(viewInstance, worldController) as Rabbit;

			rabbitActionsHelper = new RabbitReactionsHelper(_rabbit, viewInstance.stage);
		}
		
		public function get rabbit():Rabbit 
		{
			return _rabbit;
		}
		
		public function get moving():Boolean 
		{
			return keyController.isKeyDown(Keyboard.LEFT) || keyController.isKeyDown(Keyboard.RIGHT);
		}
		
		public function get direction():Number 
		{
			if (keyController.isKeyDown(Keyboard.LEFT))
				return -1;
			else if(keyController.isKeyDown(Keyboard.RIGHT))
				return 1;
			else
				return 0;
		}
		
		
	}

}