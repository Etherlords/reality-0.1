package ui.scene.gameInteractionScene
{
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import core.Box2D.utils.Box2DWorldController;
	import core.events.GameObjectPhysicEvent;
	import core.locators.PhysicWorldLocator;
	import core.locators.ServicesLocator;
	import core.scene.AbstractSceneController;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.gameobject.GameObject;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import silin.geom.FitLine;
	import silin.geom.PathPoint;
	import ui.Alert;
	import ui.camera.TracingCamera;
	import ui.FloorShape;
	import ui.gameobjects.BaseInteractiveGameObject;
	import ui.rabbit.constructor.RabbitConstructor;
	import ui.rabbit.logic.RabbitControllerShooter;
	import ui.scene.gameInteractionScene.view.GameSceneViewTest;
	import ui.services.CameraService;
	import ui.services.scores.ScoresService;
	import utils.BoundariesConstructor;
	
	public class PlatformerTest extends AbstractSceneController
	{
		
		private var sceneView:GameSceneViewTest;
		private var worldController:Box2DWorldController;
		private var _boundaries:BoundariesConstructor;
		private var rabbitController:RabbitControllerShooter;
		
		private var lastCrationObject:BaseInteractiveGameObject;
		
	
		private var interactiveObjectsCount:int = 0;
		
		private var isGameInteractionStart:Boolean = false;
		private var alert:Alert;
		private var gameIsOver:Boolean;
		
		private var scoresService:ScoresService;
		private var path:FitLine;
		
		public function PlatformerTest()
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
			camera = new TracingCamera(rabbitController.rabbit);
			
			ServicesLocator.instance.addService(new CameraService(camera));
			
			//initilizeBuoyancyController();
			
			createPath();
			
			initGameCycles();
			
			//TODO: вынести создание объектов, если будет какая то общая большая логика вынести ее в отделньые объекты
			ServicesLocator.cameraService.cameraTarget = rabbitController.rabbit.body;
		}
		
		
		private function initGameCycles():void
		{
			var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
		}
		
		private var edges:Array = [];
		private var camera:TracingCamera;
		private var genNum:Number = 550;
		
		private function gameStep(e:TimerEvent):void
		{
			
			var size:Number = 50;
			var len:Number = 0;
			
			if(camera.tracingTarget)
				len += camera.tracingTarget.body.x - 100;
				
			if (len <= 0)
				len = 1;
				
			
			
			genNum++;
			
			len += _boundaries.width + genNum;
			len /= size; //_width * 2 / size;
				
			var i:Number = 0;
			
			if(camera.tracingTarget)
				i = Math.floor((camera.tracingTarget.body.x - 100) / size) + 2;
				
			if (i > 150)
			{
				for (var z:Number = i; z > 0; z--)
				{
					if (edges[z])
						worldController.destroyGameObject(edges[z]);
					else
						break;
				}
			}
			
			var pathPoint:PathPoint;
			for (; i < len; i++)
			{
				pathPoint = path.path.getPathPoint(i * size) ;
				
				if (!edges[i])
				{
					edges[i] = createEdge(pathPoint.x, pathPoint.y, size , size,  pathPoint.rotation);
				}
			}
			
			
			
			worldController.gameStep();
			sceneView.render();
		}
		
		private function createWorld():void
		{
			worldController = new Box2DWorldController(new Point(0, 10), sceneView.gameObjectsInstance, false);
			
			PhysicWorldLocator.instance.world = worldController.world;
		}
		
		private function createEdge(x:Number, y:Number, width:Number, height:Number, raotation:Number):GameObject
		{
			var filter:b2FilterData;
			var bodyConfig:GameobjectConfig = new GameobjectConfig();
			bodyConfig.skinClass = FloorShape;
			var model:PhysicModel = new PhysicModel(1, 0.1, 0.1);
			
			var body_2:GameObject = worldController.constructGameObject(GameObject, bodyConfig, model, sceneView.gameObjectsInstance);
			body_2.body.x = x;
			body_2.body.y = y;
			body_2.body.rotation = raotation;
			//body_2.body.width = width;
			
			var fix:b2Fixture = (body_2.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
			filter = new b2FilterData();
			//filter.maskBits = 0x0004;
			filter.categoryBits = 4;
			fix.SetFilterData(filter);
			
			return body_2;
		}
		
		private function createPath():void
		{
			var points:Array = [new Point(0, 100), new Point(0, 610)];
			
			var _y:Number = _boundaries.height;
			var _x:Number = 0;
			for (var i:Number = 0; i < 300; i++)
			{
				_x += Math.random() * 2000;
				_y +=  200 + Math.random() * 500
				points.push(new Point(_x, _y))
			}
			
			path = new FitLine(points, 0.6, FitLine.CUBIC);
			
		}
		
		private function createViewComponents():void
		{
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);
			
			_boundaries.floor.addEventListener(GameObjectPhysicEvent.COLLIDE, onFallOnFloor);
			
			rabbitController = new RabbitControllerShooter(sceneView.gameObjectsInstance, worldController, new RabbitConstructor);
			
			rabbitController.rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, onRabbitColide);
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
			
			
		}
		
		public override function activate(instance:DisplayObjectContainer):void
		{
			sceneView = new GameSceneViewTest();
			setViewComponent(sceneView);
			super.activate(instance);
			
			postInitilize();
		
		}
	
	}

}