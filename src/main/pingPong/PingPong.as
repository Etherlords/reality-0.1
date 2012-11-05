package pingPong
{

	import core.Box2D.utils.Box2DWorldController;
	import core.events.GameObjectPhysicEvent;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.locators.ServicesLocator;
	import core.scene.AbstractSceneController;
	import core.ui.KeyBoardController;
	import core.view.gameobject.GameObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
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
		private var speedUpt:Number = 1.05;
		
		private var platform:GameObject;
		private var platform2:GameObject;
		private var gameStartDialog:Alert;
		private var score:Scoreboard;
		private var ricoshetScore:Scoreboard;
		private var scoreService:SharedObjectService;
		private var mouseDown:Boolean = false;
		private var playerPlatformer:PlayerPlatformController;
		private var iiController:IIPlatformController;
		
		private var isGameInProgress:Boolean = true;
		
		
		public function PingPong()
		{
			super();
		}
		
		override protected function initilize():void
		{
			//create using services
			
			gameStartDialog = new Alert(Lables.START_SCREEN);
			
			
			
			score = new Scoreboard();
			ricoshetScore = new Scoreboard();
			scoreService = new SharedObjectService(score);
			
			super.initilize();
		}
		
		private function startRaund():void 
		{
			initGameCycles();
			
			prepareGameStart();
			
			var side:Number = 1;
			
			if (Math.random() > 0.5)
				side = -1;
				
			Mouse.cursor = 'noCursor';
			
			boll.physicalProperties.applyForce( 2 * side, -0.5 + Math.random() * 1 * side);
			//boll.physicalProperties.applyForce( -1, 0);
			
			if (view.contains(gameStartDialog))
				view.removeChild(gameStartDialog);
				
			isGameInProgress = true;
		}
		
		private function prepareGameStart():void 
		{
			platform2.body.x = 760 - platform2.body.width / 2 - 10;
			platform2.body.y = platform.body.y;
			platform.body.x = 0;
			
			boll.physicalProperties.stopXVelocity();
			boll.physicalProperties.stopYVelocity();
			
			boll.body.x = (760 - boll.body.width / 2) / 2;
			boll.body.y = (500 - boll.body.width / 2) / 2;
			
			ricoshetScore.scores = 0
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
			gameStep()
			isGameInProgress = false
			
		}
		
		private function initGameCycles():void
		{
			//var stepTimer:Timer = new Timer(0.025 * 1000);
			//stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			//stepTimer.start();
			
			if (!view.stage.hasEventListener(Event.ENTER_FRAME))
				view.stage.addEventListener(Event.ENTER_FRAME, gameStep);
		}
		
		private function stopGameCycles():void
		{
			view.stage.removeEventListener(Event.ENTER_FRAME, gameStep);
		}
		
		private function gameStep(e:Event = null):void
		{
			ricoshetScore.y = view.stage.stageHeight - ricoshetScore.height - 10;
			ricoshetScore.x = (view.stage.stageWidth - ricoshetScore.width) / 2;
			
			if (isGameInProgress)
			{
				
				worldController.gameStep();
				sceneView.render();
			}
			
			
			if (!isGameInProgress && Math.random() > 0.96)
			{
				var stars:StarAnimation = new StarAnimation();
				var viewInstance:DisplayObjectContainer = view;
			
				stars.scaleX = stars.scaleY = 0.5
				stars.alpha = 0.9;
				stars.x = boll.body.x + 15 + (-50 + Math.random() * 100)
				stars.y = boll.body.y + 40+ (-150 + Math.random() * 300);
			
				stars.gotoAndPlay(int(Math.random() * 5));
				viewInstance.addChild(stars)
			}
			
		
			
			
		}
		
		private function createWorld():void
		{
			worldController = new Box2DWorldController(new Point(0, 0), sceneView.gameObjectsInstance, false);
			
			PhysicWorldLocator.instance.world = worldController.world;
		}
		
		private function createViewComponents():void
		{
			 
			view.addChild(score);
			view.addChild(ricoshetScore);
			
			
			
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);
			
			
			platform = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			platform2 = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			
			boll = new BollConstructor().make(sceneView.gameObjectsInstance, worldController);
			
			prepareGameStart();
			
			playerPlatformer = new PlayerPlatformController(sceneView.gameObjectsInstance, worldController, platform);
			//playerPlatformer = new IIPlatformController(sceneView.gameObjectsInstance, worldController, platform, boll);
			iiController = new IIPlatformController(sceneView.gameObjectsInstance, worldController, platform2, boll);
			
			
			var keyController:KeyBoardController = new KeyBoardController(view.stage);
			keyController.registerKeyDownReaction(Keyboard.LEFT, movePlatformsLeft);
			keyController.registerKeyDownReaction(Keyboard.RIGHT, movePlatformsRight);
			keyController.registerKeyDownReaction(Keyboard.SPACE, startRaund);
			
		
			_boundaries.left.addEventListener(GameObjectPhysicEvent.COLLIDE, playerLose);
			_boundaries.right.addEventListener(GameObjectPhysicEvent.COLLIDE, iiLose);
			boll.addEventListener(GameObjectPhysicEvent.COLLIDE, onBollCollide);
			view.stage.addEventListener(MouseEvent.MOUSE_DOWN, click);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, unClick);
			
			gameStartDialog.x = (view.stage.stageWidth - gameStartDialog.width) / 2;
			gameStartDialog.y = (view.stage.stageHeight - gameStartDialog.height) / 2 - 150;
			view.addChild(gameStartDialog);
		}
		
		private function movePlatformsRight():void 
		{
			
			playerPlatformer.basex -= 5;
			iiController.basex += 5;
		}
		
		private function movePlatformsLeft():void 
		{
			playerPlatformer.basex += 5;
			iiController.basex -= 5;
		}
		
		private function iiLose(e:GameObjectPhysicEvent):void 
		{
			scoreService.updateScore(scoreService.localScore - 1);
			gameOver();
			
			
		}
		
		private function playerLose(e:GameObjectPhysicEvent):void 
		{
			scoreService.updateScore(scoreService.localScore + 1);
			
			gameOver();
		}
		
		private function gameOver():void 
		{
			Mouse.cursor = MouseCursor.AUTO;
			
			view.addChild(gameStartDialog);
			isGameInProgress = false;
		
			
		}
		
		private function unClick(e:MouseEvent):void 
		{
			mouseDown = false
		}
		
		private function click(e:MouseEvent):void 
		{
			mouseDown = true;
		}
		
		private function onBollCollide(e:GameObjectPhysicEvent):void 
		{
			var ang:Number = 0;
			
			
			e.interactionWith.applyActionView(0);
			var dir:Point = new Point();
			
			var currVel:Point = boll.physicalProperties.physicModel.linearVelocity;
			
			
			//dir.x = currVel.x * 1.15 + Math.random() * 1.5;
			//dir.y = currVel.y * (1.08) + (-10 + Math.random() * 20);
			
			speedUpt -= 0.001
			
			if (speedUpt < 1.001)
				speedUpt = 1.001;
				
			
			dir.x = currVel.x * speedUpt;
			dir.y = currVel.y * speedUpt - 0.03;
			
			if (e.interactionWith == platform || e.interactionWith == platform2)
			{
				var y_delta:Number = (boll.body.y - e.interactionWith.body.y);
				ang = (180 / 100 * y_delta) - 90;
				trace(ang);
				ang /= 3;
				ang *= GlobalConstants.DEGREE_TO_RAD
				
				intensity = 5;
				
				
				
				
				dir.x += intensity * Math.cos(ang);
				dir.y += intensity * Math.sin(ang);
				

					
				ricoshetScore.scores++;
				
				
				
			boll.physicalProperties.physicModel.linearVelocity = dir;
			}
			
			
			var stars:StarAnimation = new StarAnimation();
			var viewInstance:DisplayObjectContainer = view;
			
			stars.scaleX = stars.scaleY = 0.5
			stars.alpha = 0.9;
			stars.x = boll.body.x + 15
			stars.y = boll.body.y + 40;
			
			viewInstance.addChild(stars)
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