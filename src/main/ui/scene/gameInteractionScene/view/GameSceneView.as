package  ui.scene.gameInteractionScene.view
{
	//import com.sociodox.theminer.TheMiner;
	import core.locators.ServicesLocator;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ui.scoreboard.Scoreboard;
	import ui.snow.FallingSnowAnimation;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameSceneView extends Sprite 
	{
		private var _gameObjectsInstance:DisplayObjectContainer;
		
		private var trackCameraInstances:Vector.<DisplayObjectContainer>
		
		private var _scoreboard:Scoreboard;
		private var _snow:FallingSnowAnimation;
		
		public function GameSceneView() 
		{
			super();
			initilize();
		}
		
		public function render():void
		{
			
			//this.y = stage.stageHeight / 2 - rabbit.dimensionalProperties.y;
			
			//if (this.y < 0)	
			//	this.y = 0;
			
			var target:Point = ServicesLocator.cameraService.camera.target;
			
			for (var i:int = 0; i < trackCameraInstances.length; i++)
			{
				if (trackCameraInstances[i].y != stage.stageHeight / 2 - target.y)
					trackCameraInstances[i].y += ((stage.stageHeight / 2 - target.y) - trackCameraInstances[i].y) / 20;
				
				//trackCameraInstances[i].y = stage.stageHeight / 2 - target.y;
				
				if (trackCameraInstances[i].y < 0)
					trackCameraInstances[i].y = 0
			}
			
			
			_snow.drawingY = (trackCameraInstances[0].y);
		}
		
		public function get gameObjectsInstance():DisplayObjectContainer 
		{
			return _gameObjectsInstance;
		}
		
		public function get scoresView():Scoreboard 
		{
			return _scoreboard;
		}
		
		public function initilize():void 
		{
			trackCameraInstances = new Vector.<DisplayObjectContainer>;
			createInstances();
		}
		
		private function createInstances():void 
		{
			_snow = new FallingSnowAnimation(800);
			
			_gameObjectsInstance = new Sprite();
			
			_scoreboard = new Scoreboard();
			
			trackCameraInstances.push(_gameObjectsInstance);
			trackCameraInstances.push(_snow);
			
			
			addChild(_scoreboard);
			addChild(_gameObjectsInstance);
			addChild(_snow);
		}
		
		
		
	}

}