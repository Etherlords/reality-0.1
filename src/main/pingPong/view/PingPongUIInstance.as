package pingPong.view 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import patterns.events.LazyModeratorEvent;
	import pingPong.model.GameStatModel;
	import ui.Alert;
	import ui.Lables;
	import ui.scoreboard.Scoreboard;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingPongUIInstance extends Sprite 
	{
		private var gameStartDialog:Alert;
		private var score:Scoreboard;
		private var ricoshetScore:Scoreboard;
		private var bollSpeed:Scoreboard;
		private var model:GameStatModel;
		
		private var updatebleComponentsMap:Object = { };
		
		public function PingPongUIInstance(model:GameStatModel) 
		{
			super();
			this.model = model;
			
			initlize();
		}
		
		private function initlize():void 
		{
			gameStartDialog = new Alert(Lables.START_SCREEN);
			score = new Scoreboard();
			ricoshetScore = new Scoreboard();
			bollSpeed = new Scoreboard();
			
			updatebleComponentsMap = { 'score':score, 'ricoshet':ricoshetScore, 'bollSpeed':bollSpeed }
			
			score.scores = model.score;
			
			addChild(score);
			addChild(ricoshetScore);
			addChild(bollSpeed);
			
			//align();
			model.addEventListener(LazyModeratorEvent.UPDATE_EVENT, updateView);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function updateView(e:LazyModeratorEvent):void 
		{
			var fieldName:String = '';
			var fields:Object = model.getFieldsList();
			
			for (fieldName in fields)
				updatebleComponentsMap[fieldName].scores = model[fieldName];
		}
		
		public function shoDialog():void
		{
			addChild(gameStartDialog);
		}
		
		public function hideDialog():void
		{
			removeChild(gameStartDialog);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			align();
		}
		
		private function align():void
		{
			gameStartDialog.x = (stage.stageWidth - gameStartDialog.width) / 2;
			gameStartDialog.y = (stage.stageHeight - gameStartDialog.height) / 2 - 20;
			dynamicAlign();
		}
		
		private function dynamicAlign():void
		{
			ricoshetScore.y = stage.stageHeight - ricoshetScore.height - 10;
			ricoshetScore.x = (stage.stageWidth - ricoshetScore.width) / 2;
			bollSpeed.x = (stage.stageWidth - bollSpeed.width) / 2;
		}
		
		
		
	}

}