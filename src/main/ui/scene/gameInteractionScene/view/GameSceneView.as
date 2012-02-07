package  ui.scene.gameInteractionScene.view
{
	//import com.sociodox.theminer.TheMiner;
	import core.camera.Camera;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import ui.snow.FallingSnowAnimation;
	import ui.snow.Snow;

	
	/**
	 * ...
	 * @author 
	 */
	public class GameSceneView extends Sprite 
	{
		private var _gameObjectsInstance:DisplayObjectContainer;
		
		private var trackCameraInstances:Vector.<DisplayObjectContainer>
		private var camera:Camera;
		private var _scoresView:TextField;
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
			
			var target:Point = camera.target;
			
			for (var i:int = 0; i < trackCameraInstances.length; i++)
			{
				trackCameraInstances[i].y = stage.stageHeight / 2 - target.y;
				
				if (trackCameraInstances[i].y < 0)
					trackCameraInstances[i].y = 0
			}
			
			
			_snow.drawingY = (trackCameraInstances[0].y);
		}
		
		public function setCamera(camera:Camera):void
		{
			this.camera = camera;
		}
		
		public function get gameObjectsInstance():DisplayObjectContainer 
		{
			return _gameObjectsInstance;
		}
		
		public function get scoresView():TextField 
		{
			return _scoresView;
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
			
			_scoresView = new TextField();
			
			trackCameraInstances.push(_gameObjectsInstance);
			trackCameraInstances.push(_snow);
			
			
			addChild(_scoresView);
			addChild(_gameObjectsInstance);
			addChild(_snow);
			
			_scoresView.y = 10;
			_scoresView.x = 10;
			_scoresView.autoSize = TextFieldAutoSize.LEFT;
			_scoresView.defaultTextFormat = new TextFormat("Verdana", 20, 0xFFFFFF);
			_scoresView.text = '0';
		}
		
		
		
	}

}