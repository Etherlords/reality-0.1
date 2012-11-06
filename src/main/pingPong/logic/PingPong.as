package pingPong.logic
{

	import core.Box2D.scene.BaseBox2DScene;
	import core.events.GameObjectPhysicEvent;
	import core.GlobalConstants;
	import core.locators.ServicesLocator;
	import core.ui.KeyBoardController;
	import core.view.gameobject.GameObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import pingPong.BollCamera;
	import pingPong.logic.BollConstructor;
	import pingPong.logic.IIPlatformController;
	import pingPong.logic.PlatformConstructor;
	import pingPong.logic.PlayerPlatformController;
	import pingPong.model.GameStatModel;
	import pingPong.settings.PingPongSettingsModel;
	import pingPong.SharedObjectService;
	import pingPong.view.PingPongSceneView;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import ui.services.CameraService;
	import utils.BoundariesConstructor;
	import utils.GlobalUIContext;
	
	public class PingPong extends BaseBox2DScene
	{
		
		static private const GAMEFIELD_WIDTH:Number = 760;
		static private const GAMEFIELD_HEIGH:Number = 500;
		
		private var sceneView:PingPongSceneView;
		
		private var _boundaries:BoundariesConstructor;
		
		private var camera:BollCamera;
		private var boll:GameObject;
		
		private var intensity:Number = 1.05;
		private var speedUpt:Number = 1.07;
		
		private var platform:GameObject;
		private var platform2:GameObject;
		
		private var scoreService:SharedObjectService;
		private var mouseDown:Boolean = false;
		
		private var playerPlatformer:PlayerPlatformController;
		private var iiController:IIPlatformController;
		
		private var settings:PingPongSettingsModel;
		private var gameStatModel:GameStatModel;
		private var energyFlow:EnergyFlow;
		
		public function PingPong()
		{
			super();
		}
		
		override protected function initilize():void
		{
			//create using services
			
			
			
			gameStatModel = new GameStatModel();
			scoreService = ServicesLocator.instance.getServiceByClass(SharedObjectService) as SharedObjectService;
			settings = scoreService.settings;
			scoreService.controllScore(gameStatModel);
			
			
			
			super.initilize();
		}
		
		private function startRaund():void 
		{
			boll.applyActionView(1);
			
			prepareGameStart();
			
			var side:Number = 1;
			
			if (Math.random() > 0.5)
				side = -1;
				
			Mouse.cursor = 'noCursor';
			
			boll.physicalProperties.applyForce(settings.startBollPower * side, 0)
			
			//if (Starling.current.nativeStage.contains(gameStartDialog))
			//	Starling.current.nativeStage.removeChild(gameStartDialog);
			
			gameStatModel.ricoshet = 0;
			gameStatModel.bollSpeed = 0;
				
			isGameInProgress = true;
			
			sceneView.hideDialog();
		}
		
		private function prepareGameStart():void 
		{
			
			platform2.body.x = GAMEFIELD_WIDTH - platform2.body.width / 2 - 10;
			platform2.body.y = platform.body.y;
			platform.body.x = 0;
			
			boll.physicalProperties.stopXVelocity();
			boll.physicalProperties.stopYVelocity();
			
			boll.body.x = (GAMEFIELD_WIDTH - boll.body.width / 2) / 2;
			boll.body.y = (GAMEFIELD_HEIGH - boll.body.width / 2) / 2;
			
			sceneView.showDialog();
		}
		
		private function postInitilize():void
		{
			
			isGameInProgress = true;
			
			createWorld();
			createViewComponents();
			
			
			camera = new BollCamera(boll, new Point(GAMEFIELD_WIDTH/2, GAMEFIELD_HEIGH/2));
			
			ServicesLocator.instance.addService(new CameraService(camera));
			
			camera.tracingTarget = boll;
			
			
			
			view.x = (view.stage.stageWidth - view.width) / 2;
			
			gameStep()
			
			isGameInProgress = false
		}
		
		override protected function gameStep(e:Object = null):void
		{
			super.gameStep(e);
			
			sceneView.renderScene();
			
			//if(isGameInProgress)
				gameStatModel.bollSpeed = int((Math.abs(boll.physicalProperties.physicModel.linearVelocity.x) + Math.abs(boll.physicalProperties.physicModel.linearVelocity.y)));
			
			GlobalUIContext.debugContainer.x = view.x;
			GlobalUIContext.debugContainer.y = sceneView.gameObjectsInstance.y;
			
			if (settings.isUseBollParticles)
			{
				energyFlow.emitterX = boll.skin.x + 8;
				energyFlow.emitterY = boll.skin.y + 47;
			}
		}
		
		private function createViewComponents():void
		{
			_boundaries = new BoundariesConstructor();
			_boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);
			
			
			platform = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			platform2 = new PlatformConstructor().make(sceneView.gameObjectsInstance, worldController);
			
			boll = new BollConstructor().make(sceneView.gameObjectsInstance, worldController);
			
			prepareGameStart();
			
			playerPlatformer = new PlayerPlatformController(sceneView.gameObjectsInstance, worldController, platform);
			//playerPlatformer = new IIPlatformController(sceneView.gameObjectsInstance, worldController, platform, boll);
			iiController = new IIPlatformController(sceneView.gameObjectsInstance, worldController, platform2, boll);
			
			var keyController:KeyBoardController = new KeyBoardController(Starling.current.nativeStage);
			keyController.registerKeyDownReaction(Keyboard.LEFT, movePlatformsLeft);
			keyController.registerKeyDownReaction(Keyboard.RIGHT, movePlatformsRight);
			keyController.registerKeyDownReaction(Keyboard.SPACE, startRaund);
		
			_boundaries.left.addEventListener(GameObjectPhysicEvent.COLLIDE, playerLose);
			_boundaries.right.addEventListener(GameObjectPhysicEvent.COLLIDE, iiLose);
			
			boll.addEventListener(GameObjectPhysicEvent.COLLIDE, onBollCollide);
			GlobalUIContext.vectorStage.addEventListener(MouseEvent.MOUSE_DOWN, click);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, unClick);
			
			if (settings.isUseBollParticles)
			{
				energyFlow = new EnergyFlow();
				view.addChild(energyFlow);
			}
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

			isGameInProgress = false;
			
			var bigBlow:BigBlowEffect = createBigBlow();
			bigBlow.x = boll.body.x 
			bigBlow.y = boll.body.y + 40
			prepareGameStart();
			
			
		}
		
		private function unClick(e:MouseEvent):void 
		{
			mouseDown = false
		}
		
		private function click(e:MouseEvent):void 
		{
			return;
			mouseDown = true;
			
			if(isActivated)
				deactivate();
			else
				activate(currentViewContainer);
				
			playerPlatformer.impulse();
		}
		
		private function createBigBlow():BigBlowEffect
		{
			var blow:BigBlowEffect = new BigBlowEffect();
			
			//boll.skin.visible = false;
			boll.applyActionView(0);
			view.addChild(blow);
			
			return blow;
		}
		
		private function onBollCollide(e:GameObjectPhysicEvent):void 
		{
			var ang:Number = 0;
			var currVel:Point = boll.physicalProperties.physicModel.linearVelocity;
			
			if(e.interactionWith == platform)
				e.interactionWith.applyActionView(1, currVel.x);
			else
				e.interactionWith.applyActionView(0, currVel.x);
				
			var dir:Point = new Point();
			
			speedUpt -= 0.00175
			
			if (speedUpt < 1.008)
			if (speedUpt < 1.008)
				speedUpt = 1.008;
			
			dir.x = currVel.x * speedUpt;
			dir.y = currVel.y * speedUpt - 0.02;
			
			if (e.interactionWith == platform || e.interactionWith == platform2)
			{
				var y_delta:Number = (boll.body.y - e.interactionWith.body.y);
				ang = (180 / 100 * y_delta) - 90;
				
				ang /= 2;
				ang *= GlobalConstants.DEGREE_TO_RAD * -1;
				
				intensity = 5;
				
				var yPolar:int = 1;
				var xPolar:Number = 1;
				
				if (dir.x < 0)
					xPolar = -1;
				
				if (dir.y < 0)
					yPolar = -1;
				
				//dir.x += xPolar * intensity * Math.cos(ang);
				dir.y += yPolar * intensity * Math.sin(ang);
				
				gameStatModel.ricoshet++;
			}
			
			boll.physicalProperties.physicModel.linearVelocity = dir;
			
		}
		
		override public function deactivate():void 
		{
			
			if (!isActivated)
				return;
			
			stopGameCycles();
			sceneView.deactivate();
			
			super.deactivate();
			
			
		}
		
		public override function activate(instance:DisplayObjectContainer):void
		{
			if (isActivated)
				return;
				
			var initilize:Boolean = !sceneView
				
			if (initilize)
			{
				sceneView = new PingPongSceneView(gameStatModel);
				gameObjectsInstance = sceneView.gameObjectsInstance;
			}
			
			sceneView.activate();
			
			setViewComponent(sceneView);
			
			super.activate(instance);
			
			if (initilize)
				postInitilize();
			
			initGameCycles();
		
		}
	
	}

}