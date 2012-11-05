package ui.scene.gameInteractionScene
{
import Box2D.Dynamics.Controllers.b2BuoyancyController;
import core.Box2D.utils.Box2DWorldController;
import core.events.GameObjectPhysicEvent;
import core.GlobalConstants;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;
import core.view.gameobject.GameObject;
import extendsReality.GameObjectTailTracker;
import flash.display.DisplayObjectContainer;
import starling.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import shaders.effects.tail.taileffects.PerlinEffect;
import shaders.effects.tail.TailRenderer;
import shaders.effects.tail.TailSource;
import ui.Alert;
import ui.camera.TracingCamera;
import ui.gameobjects.BaseInteractiveGameObject;
import ui.gameobjects.GameobjectsCrationController;
import ui.Lables;
import ui.rabbit.constructor.RabbitConstructor;
import ui.rabbit.logic.RabbitController;
import ui.scene.gameInteractionScene.view.GameSceneView;
import ui.services.CameraService;
import ui.services.scores.ScoresService;
import utils.BoundariesConstructor;





public class GameSceneController extends AbstractSceneController
	{

		private var sceneView:GameSceneView;
		private var worldController:Box2DWorldController;
		private var _boundaries:BoundariesConstructor;
		private var rabbitController:RabbitController;

		private var lastCrationObject:BaseInteractiveGameObject;



		private var gamaobjectCreationController:GameobjectsCrationController;
		private var _b2BuoyancyController:b2BuoyancyController;
		private var interactiveObjectsCount:int = 0;

		private var isGameInteractionStart:Boolean = false;
		private var alert:Alert;
		private var gameIsOver:Boolean;

        private var scoresService:ScoresService;

		public function GameSceneController()
		{
			super();

		}

		override protected function initilize():void
		{
			//create using services

            

			super.initilize();
		}

		private function postInitilize():void
		{
            scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
			createWorld();
			createViewComponents();
			ServicesLocator.instance.addService(new CameraService(new TracingCamera(rabbitController.rabbit)));
			
			initilizeBuoyancyController();

			initGameCycles();

			//TODO: вынести создание объектов, если будет какая то общая большая логика вынести ее в отделньые объекты
			ServicesLocator.cameraService.cameraTarget = rabbitController.rabbit.body;

			gamaobjectCreationController = new GameobjectsCrationController(sceneView.gameObjectsInstance, _boundaries.width, worldController);


			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			triggerOvertimeObjectGeneration();
			initTailRenderer();
		}
		
		private function initTailRenderer():void 
		{
			var tailReactor:PerlinEffect = new PerlinEffect();
			var tailSource:TailSource = new TailSource(tailReactor, view.stage.stageWidth, view.stage.stageHeight);
			
			var tailRenderer:TailRenderer = new TailRenderer(tailSource.source, sceneView.effects, new GameObjectTailTracker(rabbitController.rabbit));
		}

		private function initilizeBuoyancyController():void
		{
			_b2BuoyancyController = new b2BuoyancyController();


			_b2BuoyancyController.normal.Set(0, -1);
			_b2BuoyancyController.offset = 100000 * GlobalConstants.PIXELS_TO_METR;
			_b2BuoyancyController.density = 2.0;
			//controller.useWorldGravity = false
			//controller.useDensity = true;
			_b2BuoyancyController.linearDrag = 5;
			//controller.angularDrag = 2;


			worldController.addController(_b2BuoyancyController, 'nullGravityField');

			//controller.AddBody(rabbitController.rabbit.physicalProperties.physicBodyKey);
		}

		private function initGameCycles():void
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

			_b2BuoyancyController.AddBody(currentObject.physicalProperties.physicBodyKey);
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

			rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController, new RabbitConstructor);

			rabbitController.rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, onRabbitColide);

			//var flapTrigger:FlapTriggerGameObject = worldController.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), new PhysicModel(), view) as FlapTriggerGameObject;
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


			if (isGameInteractionStart)
			{
				gameOver();
			}
		}

		private function gameOver():void
		{
			gameIsOver = true;
            scoresService.flushScores();
			alert = new Alert(Lables.getGAME_OVER_LABLE(scoresService.scores, scoresService.currentPlayerMaxScope));
			alert.x = (view.stage.stageWidth - alert.width) / 2;
			alert.y = (view.stage.stageHeight - alert.height) / 2;
			alert.y += 100;

			alert.addEventListener('playAgain', replay);

			view.addChild(alert);

			rabbitController.gameOver();


		}

		private function replay(e:Event):void
		{
			view.removeChild(alert);
			var objects:Vector.<GameObject> = worldController.gameObjectRegistryController.gameObjectsRegistry.objectsList;
            scoresService.resetScores();
			//sceneView.scoresView.scores = 0;


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
			lastCrationObject.body.y = 300;

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