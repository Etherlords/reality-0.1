package core.states.config 
{
	/**
	 * ...
	 * @author 
	 */
	public class StateConfig 
	{
		public var stateId:String;
		public var controllerClass:Class;
		
		public function StateConfig(stateId:String, controllerClass:Class) 
		{
			this.stateId = stateId;
			this.controllerClass = controllerClass;
			
		}
		
	}

}