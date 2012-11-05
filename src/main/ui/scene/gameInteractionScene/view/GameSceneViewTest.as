package  ui.scene.gameInteractionScene.view
{
	//import com.sociodox.theminer.TheMiner;
	import core.locators.ServicesLocator;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import ui.FloorShape;
	import ui.scoreboard.Scoreboard;
	import ui.services.scores.ScoresService;
	import ui.snow.FallingSnowAnimation;
	
	/**
	 * ...
	 * @author 
	 */
	
	public class GameSceneViewTest extends Sprite 
	{
		
		[Embed(source="../../../../../../assets/compiled/bt_moon_masked_but_not_filtered.png")]
		private var moonClass:Class;
		
		private var _gameObjectsInstance:DisplayObjectContainer;
		
		private var trackCameraInstances:Vector.<DisplayObjectContainer>
		
		private var _scoreboard:Scoreboard;
		private var _snow:FallingSnowAnimation;

        private var scoresService:ScoresService;
		
		private var moon:Sprite;
		private var startBack:Sprite;
		private var _effects:Sprite;

		public function GameSceneViewTest() 
		{
			super();
			initilize();
		}
		
		/**
		 * TODO вынести все эти бэкграунды все же в класс бэкграунд но для этого его нужно сначала написать :)
		 * И избавится от хардкодной логики поведения бэкграундов степень их движения и порядок расположения должны задаватся zoomFactor-ом
		 * 
		 * А внутри класса бекграунд уже можно будет описывать всякую логику рендера, эффектов и тд
		 */
		
		public function render():void
		{
			var i:int;
			//this.y = stage.stageHeight / 2 - rabbit.dimensionalProperties.y;
			
			//if (this.y < 0)	
			//	this.y = 0;
			
			var target:Point = ServicesLocator.cameraService.camera.target;
			
			for (i = 0; i < trackCameraInstances.length; i++)
			{
				if (trackCameraInstances[i].y != stage.stageHeight / 2 - target.y)
					trackCameraInstances[i].y += ((stage.stageHeight / 2 - target.y) - trackCameraInstances[i].y) 
				
				//trackCameraInstances[i].y = stage.stageHeight / 2 - target.y;
				
				if (trackCameraInstances[i].x != stage.stageWidth / 2 - target.x)
					trackCameraInstances[i].x += ((stage.stageWidth / 2 - target.x) - trackCameraInstances[i].x)
			}
			return;
			var toSort:Array = [];
			for (i = 0; i < _gameObjectsInstance.numChildren - 1; i++)
			{
				var child:Sprite = _gameObjectsInstance.getChildAt(i) as Sprite;
				
				if (child is FloorShape)
				{
					toSort.push((child as FloorShape).cube);
				}
			}
			
			toSort.sortOn('viewDistance', Array.DESCENDING);
			//trace('sort', toSort.length, _gameObjectsInstance.numChildren);
			for (i = 0; i < toSort.length; i++)
			{
				_gameObjectsInstance.setChildIndex(toSort[i].parent, i);
			}
			
		}
		
		public function get gameObjectsInstance():DisplayObjectContainer 
		{
			return _gameObjectsInstance;
		}
		
		public function get scoresView():Scoreboard 
		{
			return _scoreboard;
		}
		
		public function get effects():Sprite 
		{
			return _effects;
		}
		
		public function initilize():void 
		{
            scoresService = ServicesLocator.instance.getServiceByClass(ScoresService) as ScoresService;
			trackCameraInstances = new Vector.<DisplayObjectContainer>;
			createInstances();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			//this.y = (stage.stageHeight - startBack.height);
		}
		
		private function createInstances():void 
		{
			_gameObjectsInstance = new Sprite();
			
			trackCameraInstances.push(_gameObjectsInstance);
			
			addChild(_gameObjectsInstance);
			
			removeFromMouseWorld(_gameObjectsInstance);
		}
		
		private function removeFromMouseWorld(obj:DisplayObjectContainer):void
		{
			obj.mouseEnabled = false;
			obj.mouseChildren = false;
		}
		
		
		
	}

}