package ui.rabbit.logic 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.events.GameObjectPhysicEvent;
	import core.ui.KeyBoardController;
	import core.view.gameobject.config.GameobjectConfig;
	import features.CollectFeature;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import ui.rabbit.constructor.RabbitConstructor;
	import ui.rabbit.FlapTriggerGameObject;
	import ui.rabbit.Rabbit;
	import ui.rabbit.rabbitReactions.RabbitReactionsHelper;
	/**
	 * ...
	 * @author 
	 */
	public class RabbitController 
	{
		private var viewInstance:DisplayObjectContainer;
		
		private var rabbitActionsHelper:RabbitReactionsHelper;
		private var _rabbit:Rabbit;
		private var worldController:Box2DWorldController;
		private var flapTrigger:FlapTriggerGameObject;
		private var keyController:KeyBoardController;
		
		public function RabbitController(viewInstance:DisplayObjectContainer, worldController:Box2DWorldController) 
		{
			this.worldController = worldController;
			this.viewInstance = viewInstance;
			
			keyController = new KeyBoardController(viewInstance.stage);
			
			initilize();
		}
		
		private function initilize():void 
		{
			createRabbitView();
			manageOvertimeEvents();
			manageMouseEvents();
			manageRabbitEvents();
			
			keyController.registerKeyDownReaction(Keyboard.SPACE, tryFlap);
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
		}
		
		private function jumpAction(e:MouseEvent):void 
		{
			rabbitActionsHelper.jumpAction();
		}
		
		private function tryFlap():void 
		{
			//new CollectFeature(worldController, rabbit).doAction();
			rabbitActionsHelper.flapWingsReaction();
		}
		
		private function collideWithReaction(e:GameObjectPhysicEvent):void 
		{
			rabbitActionsHelper.rabbitAccelerateReaction();
			//worldConstructor.destroyGameObject(e.interactionWith);
			
			/**
			 * Конечно не правильно тут объект уничтожать поидеи но когда понадабится дополнительное
			 * взаимоедсвтие можно будет еракцию вынести на контроллер выше стоящий или баблить туда
			 * ивенты
			 */
			
			worldController.destroyGameObject(e.interactionWith);
		}
		
		private function createRabbitView():void 
		{
			_rabbit = RabbitConstructor.make(viewInstance, worldController) as Rabbit;
			
			flapTrigger = worldController.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), viewInstance) as FlapTriggerGameObject;
			
			rabbitActionsHelper = new RabbitReactionsHelper(_rabbit, viewInstance.stage, flapTrigger);
		}
		
		public function get rabbit():Rabbit 
		{
			return _rabbit;
		}
		
	}

}