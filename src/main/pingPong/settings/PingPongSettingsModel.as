package pingPong.settings 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingPongSettingsModel 
	{
		public var isUseBollParticles:Boolean = true;
		public var isUseSoftwareBliting:Boolean = false;
		public var isShowSettingsOnStart:Boolean = true;
		
		public var iiReactionFactor:Number = 1;
		
		public var startBollPower:Number = 2.0;
		
		public function PingPongSettingsModel() 
		{
			
		}
		
		public static function restore(obj:Object):PingPongSettingsModel
		{
			var model:PingPongSettingsModel = new PingPongSettingsModel
			
			for (var vr:String in obj)
			{
				model[vr] = obj[vr];
			}
			
			return model
		}
		
		
		
	}

}