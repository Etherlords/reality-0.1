package ui.rabbit.logic 
{
import Box2D.Dynamics.b2FilterData;
import Box2D.Dynamics.b2Fixture;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
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
import ui.rabbit.constructor.PlayerConstructor;
import ui.rabbit.rabbitReactions.PlayerReactionsHelper;

/**
	 * ...
	 * @author 
	 */
	public class PlayerControllerShooter
	{
		private var viewInstance:DisplayObjectContainer;
		
		public var playerActionsHelper:PlayerReactionsHelper;
		private var _player:GameObject;
		private var worldController:Box2DWorldController;
		private var keyController:KeyBoardController;
		private var constructor:PlayerConstructor;
		private var _lastMouseDownEvent:MouseEvent;

		public function PlayerControllerShooter(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, constructor:PlayerConstructor)
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
			createPlayerView();
			manageOvertimeEvents();
			manageMouseEvents();
			manageRabbitEvents();
			
			keyController.registerKeyDownReaction(Keyboard.UP, jumpAction);
			
			keyController.registerKeyUpReaction(Keyboard.LEFT, stop);
			keyController.registerKeyUpReaction(Keyboard.RIGHT, stop);
		}
		
		private function stop():void 
		{
			
			var velocity:Point = player.physicalProperties.physicModel.linearVelocity;
			velocity.x /= 3;
			player.physicalProperties.physicModel.linearVelocity = velocity;
		}
		
		
		
		private function manageRabbitEvents():void 
		{
			
			player.addEventListener(GameObjectPhysicEvent.COLLIDE, collideWithReaction);
		}
		
		private function manageMouseEvents():void 
		{
			viewInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandle);
		}

        protected function mouseDownHandle(event:MouseEvent):void {
            _lastMouseDownEvent = event;
            doPlayerShot();
        }

        protected function doPlayerShot():void {
            player.applyActionView(GlobalConstants.ACTION_VIEW_ATTACK);
            addBullet();
        }

		protected function addBullet():void
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
			
			bullet.body.x = player.body.x + player.body.height / 2;
			bullet.body.y = player.body.y + player.body.height / 2;
			
			bullet.physicalProperties.applyImpulse((_lastMouseDownEvent.stageX - player.body.x ) / 10, (_lastMouseDownEvent.stageY - player.body.y)/ 10);
		}
		
		private function manageOvertimeEvents():void
		{
			var updateRabbitMoveTimer:Timer = new Timer(100);
			updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, updateMovieTime);
			updateRabbitMoveTimer.start();
		}

		private function updateMovieTime(e:TimerEvent):void
		{
			if (moving)
				playerActionsHelper.move(direction);
		}

		private function jumpAction(e:* = null):void
		{
			playerActionsHelper.jumpAction();
		}
		
		private function collideWithReaction(e:GameObjectPhysicEvent):void 
		{
			if (!(e.interactionWith is BaseInteractiveGameObject))
			{
				return;
			}
			
			playerActionsHelper.accelerateReaction();
			

			/**
			 * Конечно не правильно тут объект уничтожать поидеи но когда понадабится дополнительное
			 * взаимоедсвтие можно будет еракцию вынести на контроллер выше стоящий или баблить туда
			 * ивенты
			 */
			(e.interactionWith as BaseInteractiveGameObject).interactiveObjectConfig.destructionAlgorithm.execute();
			worldController.destroyGameObject(e.interactionWith);
		}
		
		private function createPlayerView():void
		{
			
			_player = constructor.make(viewInstance, worldController);

			playerActionsHelper = new PlayerReactionsHelper(player, viewInstance.stage);
		}
		
		public function get player():GameObject
		{
			return _player;
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