package ui.rabbit.logic 
{
import core.Box2D.utils.Box2DWorldController;
import core.events.GameObjectPhysicEvent;
import core.ui.KeyBoardController;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.ui.Keyboard;
import flash.utils.Timer;

import ui.gameobjects.BaseInteractiveGameObject;
import ui.rabbit.FlapTriggerGameObject;
import ui.rabbit.Rabbit;
import ui.rabbit.constructor.PlayerConstructor;
import ui.rabbit.rabbitReactions.PlayerReactionsHelper;

/**
	 * ...
	 * @author 
	 */
	public class RabbitController 
	{
		private var viewInstance:DisplayObjectContainer;
		
		public var rabbitActionsHelper:PlayerReactionsHelper;
		private var _rabbit:Rabbit;
		private var worldController:Box2DWorldController;
		private var flapTrigger:FlapTriggerGameObject;
		private var keyController:KeyBoardController;
		private var direction:Number;
		private var moving:Boolean;
		private var constructor:PlayerConstructor;
		
		public function RabbitController(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController, constructor:PlayerConstructor) 
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
			keyController.registerKeyDownReaction(Keyboard.LEFT, Delegate.create(isMove, -1));
			keyController.registerKeyDownReaction(Keyboard.RIGHT, Delegate.create(isMove, 1));
			
			keyController.registerKeyUpReaction(Keyboard.LEFT, stop);
			keyController.registerKeyUpReaction(Keyboard.RIGHT, stop);
		}
		
		private function stop():void 
		{
			moving = false;
		}
		
		private function isMove(direction:Number):void 
		{
			
			this.direction = direction;
			moving = true;
			
		}
		
		private function manageRabbitEvents():void 
		{
			
			rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, collideWithReaction);
		}
		
		private function manageMouseEvents():void 
		{
			 viewInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, jumpAction);
			//viewInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, tryFlap);
		}
		
		private function manageOvertimeEvents():void 
		{
			var updateRabbitMoveTimer:Timer = new Timer(100);
			updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, rabbitMovieTime);
			updateRabbitMoveTimer.start();
		}
		
		private function rabbitMovieTime(e:TimerEvent):void 
		{
			rabbitActionsHelper.calculateObjectMoving();
			
			if (moving)
				rabbitActionsHelper.move(direction);
		}
		
		private function jumpAction(e:MouseEvent):void 
		{
			rabbitActionsHelper.jumpAction();
		}
		
		private function tryFlap():void 
		{
			rabbitActionsHelper.jumpAction();
			//new CollectFeature(worldController, rabbit).doAction();
			//rabbitActionsHelper.flapWingsReaction();
		}
		
		private function collideWithReaction(e:GameObjectPhysicEvent):void 
		{
			
			if (!(e.interactionWith is BaseInteractiveGameObject))
			{
				return;
			}
			
			rabbitActionsHelper.accelerateReaction();
			
			
			//worldConstructor.destroyGameObject(e.interactionWith);
			
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
			//_rabbit = TestWithJoint.make(viewInstance, worldController) as Rabbit;
			_rabbit = constructor.make(viewInstance, worldController) as Rabbit;
			
			//flapTrigger = worldController.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), new PhysicModel(), viewInstance) as FlapTriggerGameObject;
			
			rabbitActionsHelper = new PlayerReactionsHelper(_rabbit, viewInstance.stage, flapTrigger);
		}
		
		public function get rabbit():Rabbit 
		{
			return _rabbit;
		}
		
	}

}