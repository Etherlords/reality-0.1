package pingPong.settings.model 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class UILables 
	{
		public static var texts:Object = {
										'isUseBollParticles':'Эфект частиц на шаре',
										'isUseSoftwareBliting':'Софтварная отрисовка',
										'isShowSettingsOnStart':'Настройки при запуске'
									}
									
									
		public static const GENERAL_HINT:String = 'Софтварная отрисовка может улучшить производительность в хроме'
													+ '\n'
													//+ '
		
		
		private static const componentNameFlag:String = '%componentName%'
		private static const statusFlag:String = '%status%'
		
		public static var SWITCH_LABLE:String = '%componentName% %status%';
		
		public static function getSwitchText(componentName:String, status:Boolean):String
		{
			return SWITCH_LABLE.split(componentNameFlag).join(texts[componentName]).split(statusFlag).join(status? 'ON':'OFF');
		}
		
	}

}