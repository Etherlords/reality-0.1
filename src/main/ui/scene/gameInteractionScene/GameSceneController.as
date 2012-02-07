package ui.scene.gameInteractionScene 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.events.GameObjectPhysicEvent;
	import core.locators.PhysicWorldLocator;
	import core.scene.AbstractSceneController;
	import core.ui.KeyBoardController;
	import core.view.gameobject.config.GameobjectConfig;
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import ui.Bell;
	import ui.camera.TracingCamera;
	import ui.rabbit.FlapTriggerGameObject;
	import ui.rabbit.logic.RabbitController;
	import ui.rabbit.rabbitReactions.RabbitReactionsHelper;
	import ui.scene.gameInteractionScene.view.GameSceneView;
	import ui.utils.objectContructors.BellConstructor;
	import utils.BoundariesConstructor;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameSceneController extends AbstractSceneController 
	{
		
		private var sceneView:GameSceneView;
		private var rabbitReactonsHelper:RabbitReactionsHelper;
		private var worldController:Box2DWorldController;
		private var _boundaries:BoundariesConstructor;
		private var rabbitController:RabbitController;
		private var camera:TracingCamera;
		private var lastBell:Bell;
		
		private var scoresSubstractor:Number = 10;
		private var scores:Number = 0;
		private var keyController:KeyBoardController;
		
		public function GameSceneController() 
		{
			super();
			
		}
		
		private function postInitilize():void 
		{
			createWorld();
			createViewComponents();
			
			keyController = new KeyBoardController(view.stage);
			
			manageEvents();
			initGameInitrations();
			
			//TODO: вынести создание объектов, если будет какая то общая большая логика вынести ее в отделньые объекты
			
			
			
			camera = new TracingCamera(rabbitController.rabbit.body);
			
			sceneView.setCamera(camera);
			
			generateBell();
			generateBell();
			generateBell();
			generateBell();
			generateBell();
		}
		
		private function initGameInitrations():void 
		{
			var generateBellTimer:Timer = new Timer(1000);
			generateBellTimer.addEventListener(TimerEvent.TIMER, generateBell);
			generateBellTimer.start();
			
			 var stepTimer:Timer = new Timer(0.025 * 1000);
			stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
			stepTimer.start();
		}
		
		private function gameStep(e:TimerEvent):void 
		{
			worldController.gameStep();
			sceneView.render();
		}
		
		private function generateBell(e:* = null):void 
		{	
			lastBell = BellConstructor.make(camera, lastBell, sceneView.gameObjectsInstance, _boundaries.width, worldController) as Bell;
			lastBell.addEventListener(GameObjectPhysicEvent.DESTROY, bellDestoryReaction);
		}
		
		private function bellDestoryReaction(e:GameObjectPhysicEvent):void 
		{
			generateBell();
			
			scores += scoresSubstractor;
			scoresSubstractor += 10;
			
			sceneView.scoresView.text = scores.toString();
		}
		
		private function manageEvents():void 
		{
			//view.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//view.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			//rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, rabbitColideWith);
			
			keyController.registerKeyDownReaction(Keyboard.SPACE, onSpaceIsDown);
		}
		
		private function onSpaceIsDown():void 
		{
			trace('space is down', arguments);
		}
		
		private function createWorld():void 
		{
			
			worldController = new Box2DWorldController(new Point(0, 10), sceneView.gameObjectsInstance, true);
			
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