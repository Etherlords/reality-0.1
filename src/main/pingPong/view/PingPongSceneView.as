package  pingPong.view
{
	//import com.sociodox.theminer.TheMiner;
	import core.locators.ServicesLocator;
	import flash.geom.Point;
	import pingPong.model.GameStatModel;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.scoreboard.Scoreboard;
	import ui.services.scores.ScoresService;
	import utils.GlobalUIContext;
	
	/**
	 * ...
	 * @author 
	 */
	
	public class PingPongSceneView extends Sprite 
	{
		
		private var _gameObjectsInstance:Sprite;
		private var uiInstance:PingPongUIInstance;
		
		private var trackCameraInstances:Vector.<DisplayObjectContainer>
		
		private var _scoreboard:Scoreboard;

        private var scoresService:ScoresService;
		
		private var startBack:Sprite;
		private var gameStatModel:GameStatModel;

		public function PingPongSceneView(gameStatModel:GameStatModel) 
		{
			super();
			this.gameStatModel = gameStatModel;
			initilize();
		}
		
		public function renderScene():void
		{
			var i:int;
			
			var target:Point = ServicesLocator.cameraService.camera.target;
			
			for (i = 0; i < trackCameraInstances.length; i++)
			{
				trackCameraInstances[i].y = (stage.stageHeight / 2 - target.y)
				trackCameraInstances[i].x = (stage.stageWidth / 2 - target.x);
			}
			
		}
		
		public function deactivate():void
		{
			removeChild(_gameObjectsInstance);
			GlobalUIContext.vectorUIContainer.removeChild(uiInstance);
		}
		
		public function activate():void
		{
			addChild(_gameObjectsInstance);
			GlobalUIContext.vectorUIContainer.addChild(uiInstance);
		}
		
		public function showDialog():void 
		{
			uiInstance.shoDialog();
		}
		
		public function hideDialog():void 
		{
			uiInstance.hideDialog();
		}
		
		public function initilize():void 
		{
            scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
			trackCameraInstances = new Vector.<DisplayObjectContainer>;
			createInstances();
			createComponents();
		}
		
		private function createComponents():void 
		{
			
		}
		
		private function createInstances():void 
		{
			_gameObjectsInstance = new Sprite();
			uiInstance = new PingPongUIInstance(gameStatModel);
			
			trackCameraInstances.push(_gameObjectsInstance);
			
			
		}
		
		public function get gameObjectsInstance():DisplayObjectContainer 
		{
			return _gameObjectsInstance;
		}
		
		public function get scoresView():Scoreboard 
		{
			return _scoreboard;
		}
		
	}

}