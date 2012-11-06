package pingPong 
{
	import core.locators.ServicesLocator;
	import core.services.AbstractService;
	import flash.net.registerClassAlias;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import pingPong.model.GameStatModel;
	import pingPong.settings.PingPongSettingsModel;
	import ui.scoreboard.Scoreboard;
	/**
	 * ...
	 * @author Nikro
	 */
	public class SharedObjectService extends AbstractService
	{
		private var gameStat:GameStatModel;
		
		private var shared:SharedObject;
		private var _settings:PingPongSettingsModel;
		public var localScore:Number = 0;
		
		public function SharedObjectService() 
		{
			registerClassAlias('PingPongSettingsModel', PingPongSettingsModel);
			init();
			
			ServicesLocator.instance.addService(this);
		}
		
		public function controllScore(gameStat:GameStatModel):void
		{
			this.gameStat = gameStat;
			checkScore();
		}
		
		private function init():void 
		{
			shared = SharedObject.getLocal("pingPong9000");
		}
		
		private function checkScore():void 
		{
			var sharedScore:Number = shared.data.score;
			
			if (sharedScore && !isNaN(sharedScore))
				localScore = sharedScore;
		
				
			gameStat.score = localScore;
		}
		
		public function uploadSettings():void
		{
			shared.data.settings = _settings;
			shared.flush();
		}
		
		public function get settings():PingPongSettingsModel
		{
			if(!_settings)
				_settings = shared.data.settings || new PingPongSettingsModel();
				
			
			
			return _settings
		}
		
		public function updateScore(value:Number):void
		{
			localScore = value;
			gameStat.score = localScore;
			
			shared.data.score =  value;
			shared.flush();
		}
		
	}

}