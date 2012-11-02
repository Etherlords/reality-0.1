package pingPong
{

	import core.Box2D.utils.Box2DWorldController;
	import core.camera.Camera;
	import core.events.GameObjectPhysicEvent;
	import core.locators.PhysicWorldLocator;
	import core.locators.ServicesLocator;
	import core.scene.AbstractSceneController;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import pingPong.BollCamera;
	import pingPong.BollConstructor;
	import pingPong.IIPlatformController;
	import pingPong.PlatformConstructor;
	import pingPong.PlayerPlatformController;
	import pingPong.SharedObjectService;
	import ui.Alert;
	import ui.Lables;
	import ui.scene.gameInteractionScene.view.GameSceneViewTest;
	import ui.scoreboard.Scoreboard;
	import ui.services.CameraService;
	import utils.BoundariesConstructor;
	
	public class PingPong extends AbstractSceneController
	{
		private var sceneView:GameSceneViewTest;
		private var worldController:Box2DWorldController;
		private var _boundaries:BoundariesConstructor;
		
		private var camera:BollCamera;
		private var boll:GameObject;
		
		private var intensity:Number = 1.05;
		private var platform:GameObject;
		private var platform2:GameObject;
		private var gameStartDialog:Alert;
		private var score:Scoreboard;
		private var scoreService:SharedObjectService;
		
		
		public function PingPong()
		{
			super();
		}
		
		override protected function initilize():void
		{
			//create using services
			
			gameStartDialog = new Alert(Lables.START_SCREEN);
			gameStartDialog.addEventListener("startGame", startRaund);
			
			
			score = new Scoreboard();
			scoreService = new SharedObjectService(score);
			
			super.initilize();
		}
		
		private function startRaund(e:Event):void 
		{
			prepareGameStart();
			
			var side:Number = 1;
			
			if (Math.random() > 0.5)
				side = -1;
				
			Mouse.cursor = 'noCursor';
			
			boll.physicalProperties.applyForce( 2 * side, 2, -2.5 * Math.random() * 5, -2.5 * Math.random() * 5);
			view.removeChild(gameStartDialog);
		}
		
		private function prepareGameStart():void 
		{
			boll.physicalProperties.stopXVelocity();
			boll.physicalProperties.stopYVelocity();
			
			boll.body.x = (760 - boll.body.width) / 2;
			boll.body.y = (500 - boll.body.width) / 2;
		}
		
		private function postInitilize():void
		{
			
			createWorld();
			createViewComponents();
			camera = new BollCamera(boll, new Point(760/2, 500/2));
			
			ServicesLocator.instance.addService(new CameraService(camera));
			camera.tracingTarget = boll;
			initGameCycles();
			
			view.x = (view.stage.stageWidth - view.width) / 2;
		}
		
		private function initGameCycles():void
		{
			var stepTimer:Timer = new Timer(0.005 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
		}
		
		private function gameStep(e:TimerEvent):void
		{
			worldController.gameStep();
			sceneView.render();
		}
		
		private function createWorld():void
		{
			worldController = new Box2DWorldController(new Point(0, 0), sceneView.gameObjectsInstance, false);
			
			PhysicWorldLocator.instance.world = worldController.world;
		}
		
		private function createViewComponents():void
		{
			
			view.addChild(score);
			
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);
			
			
			platform = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			platform2 = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			
			boll = new BollConstructor().make(sceneView.gameObjectsInstance, worldController);
			var playerPlatformer:PlayerPlatformController = new PlayerPlatformController(sceneView.gameObjectsInstance, worldController, platform);
			var iiController:IIPlatformController = new IIPlatformController(sceneView.gameObjectsInstance, worldController, platform2, boll);
			
			
			platform2.body.x = 760 - platform2.body.width / 2 - 10;
			platform2.body.y = platform.body.y;
			platform.body.x = 10;
			
			prepareGameStart();
			
		
			_boundaries.left.addEventListener(GameObjectPhysicEvent.COLLIDE, playerLose);
			_boundaries.right.addEventListener(GameObjectPhysicEvent.COLLIDE, iiLose);
			boll.addEventListener(GameObjectPhysicEvent.COLLIDE, onBollCollide);
			
			gameStartDialog.x = (view.stage.stageWidth - gameStartDialog.width) / 2;
			gameStartDialog.y = (view.stage.stageHeight - gameStartDialog.height) / 2;
			view.addChild(gameStartDialog);
		}
		
		private function iiLose(e:GameObjectPhysicEvent):void 
		{
			scoreService.updateScore(scoreService.localScore - 1);
			gameOver();
			Mouse.cursor = MouseCursor.AUTO;
			
		}
		
		private function playerLose(e:GameObjectPhysicEvent):void 
		{
			scoreService.updateScore(scoreService.localScore + 1);
			
			gameOver();
		}
		
		private function gameOver():void 
		{
			prepareGameStart();
			view.addChild(gameStartDialog);
		}
		
		private function onBollCollide(e:GameObjectPhysicEvent):void 
		{
			e.interactionWith.applyActionView(0);
			var dir:Point = new Point();
			
			var currVel:Point = boll.physicalProperties.physicModel.linearVelocity;
			
			
			dir.x = currVel.x * intensity;
			dir.y = currVel.y * intensity;
			
			boll.physicalProperties.physicModel.linearVelocity = dir;
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