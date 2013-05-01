package core.ioc.metacommands 
{
	/**
	 * Метатег который будет отвечат за модерацию поля в объекте типа моедратор
	 * Т.е поля помеченые тегом будут автаматически следить за своим изменением
	 * что то типа биндинга
	 * @author Nikro
	 */
	public class Moderable extends AbstractMetacommand 
	{
		
		public function Moderable() 
		{
			super();
			
		}
		
	}

}