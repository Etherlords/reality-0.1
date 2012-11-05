package ui.scene.gameInteractionScene
{
import Box2D.Dynamics.Controllers.b2BuoyancyController;
import core.Box2D.utils.Box2DWorldController;
import core.events.GameObjectPhysicEvent;
import core.GlobalConstants;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.GameObject;
import core.view.gameobject.physicalpropeties.PhysicModel;
import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
import features.MagnetField;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import starling.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;
import flash.utils.Timer;
import ui.Alert;
import ui.BaloonShape;
import ui.gameobjects.BaseInteractiveGameObject;
import ui.gameobjects.GameobjectsCrationController;
import ui.Lables;
import ui.rabbit.constructor.TestWithJoint;
import ui.rabbit.FlapTriggerGameObject;
import ui.rabbit.logic.RabbitController;
import ui.rabbit.Rabbit;
import ui.scene.gameInteractionScene.view.GameSceneView;
import ui.services.CameraService;
import ui.services.scores.ScoresService;
import utils.BoundariesConstructor;





public class HighDelivery extends AbstractSceneController
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

		public function HighDelivery()
		{
			super();

		}

		override protected function initilize():void
		{
			//create using services

            ServicesLocator.instance.addService(new CameraService());

			super.initilize();
		}

		private function postInitilize():void
		{
            scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
			
			createWorld();
			
			initilizeBuoyancyController();

			
			createViewComponents();
			
			

			
			initGameCycles();

			//TODO: вынести создание объектов, если будет какая то общая большая логика вынести ее в отделньые объекты
			ServicesLocator.cameraService.cameraTarget = rabbitController.rabbit.body;

			gamaobjectCreationController = new GameobjectsCrationController(sceneView.gameObjectsInstance, _boundaries.width, worldController);


			//triggerOvertimeObjectGeneration();
			//triggerOvertimeObjectGeneration();
			//triggerOvertimeObjectGeneration();
			//triggerOvertimeObjectGeneration();
			//triggerOvertimeObjectGeneration();
		}

		private function initilizeBuoyancyController():void
		{
			_b2BuoyancyController = new b2BuoyancyController();


			_b2BuoyancyController.normal.Set(0, -1);
			_b2BuoyancyController.offset = 100000 * GlobalConstants.PIXELS_TO_METR;
			_b2BuoyancyController.density = 2.6;
			//controller.useWorldGravity = false
			//controller.useDensity = true;
			_b2BuoyancyController.linearDrag = 5;
			_b2BuoyancyController.angularDrag = 0;


			worldController.addController(_b2BuoyancyController, 'nullGravityField');

			//controller.AddBody(rabbitController.rabbit.physicalProperties.physicBodyKey);
		}

		private function initGameCycles():void
		{
			var overtimeObjectGeneration:Timer = new Timer(1);
			overtimeObjectGeneration.addEventListener(TimerEvent.TIMER, triggerOvertimeObjectGeneration);
			overtimeObjectGeneration.start();

			 var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
			
			view.addEventListener(MouseEvent.MOUSE_MOVE, onMouse);
			
			//Mouse.hide();
			
			Mouse.cursor = 'noCursor';
		}
		
		private function onMouse(e:MouseEvent):void 
		{
			if (!cameraView || view)
				return;
				
			cameraView.body.x = view.mouseX - cameraView.body.width / 2;
			cameraView.body.y =  (view.mouseY) - cameraView.body.height / 2;
			//Mouse.hide();
		}
		
		private var cameraView:GameObject;
		private function gameStep(e:TimerEvent):void
		{
			if (!cameraView && worldController.world)
			{
				var conf:GameobjectConfig = new GameobjectConfig();
				conf.skinClass = BaloonShape;
				conf.type = 3;
				
				cameraView = worldController.constructGameObject(GameObject, conf, new PhysicModel, this.sceneView);
				(cameraView.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList().SetSensor(true);
			}

			worldController.gameStep();
			sceneView.render();
			//trace(ServicesLocator.cameraService.camera.tracingTarget.y + (view.mouseY - 560));
			cameraView.body.x = view.mouseX - cameraView.body.width / 2;
			cameraView.body.y =  (view.mouseY) - cameraView.body.height / 2;// + ServicesLocator.cameraService.camera.tracingTarget.y - 270;
			//trace( ServicesLocator.cameraService.camera.target.y);
			//trace('viewY', view.mouseY + ServicesLocator.cameraService.camera.target.y);
			var newControll:MagnetField = new MagnetField(worldController, new Point(view.mouseX, (view.mouseY)));
			newControll.doAction(25, 150, false, flotterFilter);
			
			newControll = new MagnetField(worldController, new Point(rabbitController.rabbit.body.x + rabbitController.rabbit.body.width/2, rabbitController.rabbit.body.y + rabbitController.rabbit.body.height/2));
			newControll.doAction(15, 100, true, collectorFilter);
		}
		
		private function collectorFilter(object:GameObject):Boolean 
		{
			return !(object is Rabbit) && !(object is FlapTriggerGameObject);
		}
		
		private function flotterFilter(object:GameObject):Boolean 
		{
			return !(object is Rabbit) && !(object is FlapTriggerGameObject) && !(object is BaseInteractiveGameObject);
		}

		private function triggerOvertimeObjectGeneration(e:* = null):void
		{
			if (gameIsOver)
				return;

			if (interactiveObjectsCount > 15)
				return;

			interactiveObjectsCount++;
			
			
			var currentObject:BaseInteractiveGameObject = gamaobjectCreationController.createGameobjectOvertimeTrigger(lastCrationObject)
			currentObject.body.y = -40;
			
			
			//if (currentObject is FlowInteractiveObject)
			//{
				lastCrationObject = currentObject;
			//}
			
			currentObject.physicalProperties.physicModel.density = 2.8;
			currentObject.physicalProperties.physicModel.fixedRotation = true;
			
			_b2BuoyancyController.AddBody(currentObject.physicalProperties.physicBodyKey);
			currentObject.interactiveObjectConfig.creationAlgorithm.execute();

			currentObject.addEventListener(GameObjectPhysicEvent.DESTROY, interactiveObjectDestructionTrigger);
		}

		private function interactiveObjectDestructionTrigger(e:GameObjectPhysicEvent):void
		{
			var interactiveObject:BaseInteractiveGameObject = e.interactionWith as BaseInteractiveGameObject;


			interactiveObjectsCount--;

			if (interactiveObjectsCount == 0 && gameIsOver)
			{
				startNewGame();
			}
		}

		private function createWorld():void
		{
			worldController = new Box2DWorldController(new Point(0, 10), sceneView.gameObjectsInstance, true);

			PhysicWorldLocator.instance.world = worldController.world;
		}

		private function createViewComponents():void
		{
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);

			//_boundaries.floor.addEventListener(GameObjectPhysicEvent.COLLIDE, onFallOnFloor);
			
			rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController, new TestWithJoint());

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