package ui.scene.gameInteractionScene 
{
import Box2D.Dynamics.Controllers.b2BuoyancyController;
import core.view.gameobject.GameObject;
import flash.events.Event;
import ui.Alert;
import ui.gameobjects.simpleFlowObject.FlowInteractiveObject;
import ui.Lables;
import ui.rabbit.Rabbit;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
import core.events.GameObjectPhysicEvent;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;
import core.view.gameobject.config.GameobjectConfig;

import flash.display.DisplayObjectContainer;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import ui.gameobjects.BaseInteractiveGameObject;
import ui.gameobjects.GameobjectsCrationController;
import ui.rabbit.FlapTriggerGameObject;
import ui.rabbit.logic.RabbitController;
import ui.rabbit.rabbitReactions.RabbitReactionsHelper;
import ui.scene.gameInteractionScene.view.GameSceneView;
import ui.services.CameraService;
import ui.services.ScoreboardService;

import utils.BoundariesConstructor;

public class GameSceneController extends AbstractSceneController
	{
		
		private var sceneView:GameSceneView;
		private var rabbitReactonsHelper:RabbitReactionsHelper;
		private var worldController:Box2DWorldController;
		private var _boundaries:BoundariesConstructor;
		private var rabbitController:RabbitController;
		
		private var lastCrationObject:BaseInteractiveGameObject;
		
		private var scoresSubstractor:Number = 10;
		private var scores:Number = 0;
		
		private var gamaobjectCreationController:GameobjectsCrationController;
		private var controller:b2BuoyancyController;
		private var interactiveObjectsCount:int = 0;
		
		private var isGameInteractionStart:Boolean = false;
		private var alert:Alert;
		private var gameIsOver:Boolean;
		
		public function GameSceneController() 
		{
			super();
			
		}
		
		override protected function initilize():void 
		{
			//create using services
            ServicesLocator.instance.addService(new CameraService());
            ServicesLocator.instance.addService(new ScoreboardService());

			super.initilize();
		}
		
		private function postInitilize():void 
		{
			createWorld();
			createViewComponents();
			
			initilizeBuoyancyController();
			
			
			manageEvents();
			initGameInitrations();
			
			//TODO: вынести создание объектов, если будет какая то общая большая логика вынести ее в отделньые объекты
			ServicesLocator.cameraService.cameraTarget = rabbitController.rabbit.body;
			ServicesLocator.scoreboardService.scoreboard = sceneView.scoresView;
			
			gamaobjectCreationController = new GameobjectsCrationController(sceneView.gameObjectsInstance, _boundaries.width, worldController);
			
			
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
		}
		
		private function initilizeBuoyancyController():void 
		{
			controller = new b2BuoyancyController();
			
			
			controller.normal.Set(0, -1);
			controller.offset = 100000 * GlobalConstants.PIXELS_TO_METR;
			controller.density = 2.0;
			//controller.useWorldGravity = false
			//controller.useDensity = true;
			controller.linearDrag = 5;
			//controller.angularDrag = 2;
			

			worldController.addController(controller, 'nullGravityField');
			
			//controller.AddBody(rabbitController.rabbit.physicalProperties.physicBodyKey);
		}
		
		private function initGameInitrations():void 
		{
			var overtimeObjectGeneration:Timer = new Timer(300);
			overtimeObjectGeneration.addEventListener(TimerEvent.TIMER, triggerOvertimeObjectGeneration);
			overtimeObjectGeneration.start();
			
			 var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
		}
		
		private function gameStep(e:TimerEvent):void 
		{
			worldController.gameStep();
			sceneView.render();
		}
		
		private function triggerOvertimeObjectGeneration(e:* = null):void 
		{	
			if (gameIsOver)
				return;
			
			if (interactiveObjectsCount > 15)
				return;
			
			interactiveObjectsCount++;
				
			var currentObject:BaseInteractiveGameObject = gamaobjectCreationController.createGameobjectOvertimeTrigger(lastCrationObject)
			
			//if (currentObject is FlowInteractiveObject)
			//{
				lastCrationObject = currentObject;
			//}
			
			controller.AddBody(currentObject.physicalProperties.physicBodyKey);
			currentObject.interactiveObjectConfig.creationAlgorithm.execute();
			
			currentObject.addEventListener(GameObjectPhysicEvent.DESTROY, interactiveObjectDestructionTrigger);
		}
		
		private function interactiveObjectDestructionTrigger(e:GameObjectPhysicEvent):void 
		{
			var interactiveObject:BaseInteractiveGameObject = e.interactionWith as BaseInteractiveGameObject;
			
			
			interactiveObjectsCount--;
			
			if (!gameIsOver)
			{
				
				
			}
			
			if (interactiveObjectsCount == 0 && gameIsOver)
			{
				startNewGame();
			}
		}
		
		private function bellDestoryReaction(e:GameObjectPhysicEvent):void 
		{
			triggerOvertimeObjectGeneration();
			
			sceneView.scoresView.scores += scoresSubstractor;
			scoresSubstractor += 10;
		}
		
		private function manageEvents():void 
		{
			//view.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//view.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			//rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, rabbitColideWith);
			
			
			
		}
		
		private function onSpaceIsDown():void 
		{
			
		}
		
		private function createWorld():void 
		{
			worldController = new Box2DWorldController(new Point(0, 10), sceneView.gameObjectsInstance, false);
			
			PhysicWorldLocator.instance.world = worldController.world;
		}

		private function createViewComponents():void 
		{
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);
			
			_boundaries.floor.addEventListener(GameObjectPhysicEvent.COLLIDE, onFallOnFloor);
			
			rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController);
			
			rabbitController.rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, onRabbitColide);
			
			var flapTrigger:FlapTriggerGameObject = worldController.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), view) as FlapTriggerGameObject;
		}
		
		private function onRabbitColide(e:GameObjectPhysicEvent):void 
		{
			if (!(e.interactionWith is BaseInteractiveGameObject))
			{
				return;
			}
			
			
			isGameInteractionStart = true;
		}
		
		private function onFallOnFloor(e:GameObjectPhysicEvent):void 
		{
			trace(e.interactionWith.physicalProperties.linearVelocity);
			
			if (isGameInteractionStart)
			{
				gameOver();
			}
		}
		
		private function gameOver():void 
		{
			gameIsOver = true;
			
			alert = new Alert(Lables.getGAME_OVER_LABLE(sceneView.scoresView.scores, 9999999));
			alert.x = (view.stage.stageWidth - alert.width) / 2;
			alert.y = (view.stage.stageHeight - alert.height) / 2;
			
			alert.addEventListener('playAgain', replay);
			
			view.addChild(alert);
			
			rabbitController.gameOver();
			
			
		}
		
		private function replay(e:Event):void 
		{
			view.removeChild(alert);
			var objects:Vector.<GameObject> = worldController.gameObjectsRegistry.objectsList;
			sceneView.scoresView.scores = 0;
			
			
			for (var i:int = 0; i < objects.length; i++)
			{
				
				if ((objects[i] is BaseInteractiveGameObject))
				{
					//TODO деревянный метод жду пока не удалю все объекты и патом реиницилизирую игру
					objects[i].destroy();
					//objects[i].preRender(0);
					//sceneView.scoresView.scores -= 10;
				}
			}
			
			
			
		}
		
		private function startNewGame():void
		{
			lastCrationObject = null;
			rabbitController.replay();
			
			isGameInteractionStart = false;
			gameIsOver = false
			
			//interactiveObjectsCount = 0;
			
			triggerOvertimeObjectGeneration();
			
			//TODO хз почему после удаления всхе объектов координата 300 стала выше на 100..
			lastCrationObject.body.y = 500;
			
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
		}
		
		public override function activate(instance:DisplayObjectContainer):void
		{		
			sceneView = new GameSceneView();
			setViewComponent(sceneView);
			super.activate(instance);

			postInitilize();
			
		}
		
	}

}