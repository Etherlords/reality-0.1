package ui.scene.gameInteractionScene 
{
	import core.Box2D.utils.Box2DWorldController;
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
		
		public function GameSceneController() 
		{
			super();
			
		}
		
		override protected function initilize():void 
		{
			//create using services
			var camersService:CameraService = new CameraService();
			var scoreboardService:ScoreboardService = new ScoreboardService();
			
			super.initilize();
		}
		
		private function postInitilize():void 
		{
			createWorld();
			createViewComponents();
			
			
			
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
			lastCrationObject = gamaobjectCreationController.createGameobjectOvertimeTrigger(lastCrationObject)
			lastCrationObject.interactiveObjectConfig.creationAlgorithm.execute();
			
			lastCrationObject.addEventListener(GameObjectPhysicEvent.DESTROY, interactiveObjectDestructionTrigger);
		}
		
		private function interactiveObjectDestructionTrigger(e:GameObjectPhysicEvent):void 
		{
			var interactiveObject:BaseInteractiveGameObject = e.interactionWith as BaseInteractiveGameObject;
			
			
			interactiveObject.interactiveObjectConfig.destructionAlgorithm.execute();
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
			_boundaries.createBoundaries();
			
			rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController);
			
			var flapTrigger:FlapTriggerGameObject = worldController.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), view) as FlapTriggerGameObject;
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