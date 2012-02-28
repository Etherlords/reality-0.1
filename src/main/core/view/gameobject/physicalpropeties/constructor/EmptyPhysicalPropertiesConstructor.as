package core.view.gameobject.physicalpropeties.constructor 
{
	import core.body.IBodyPresentation;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;


	public class EmptyPhysicalPropertiesConstructor implements IPhysicalPropertiesConstructor 
	{
		public function EmptyPhysicalPropertiesConstructor() 
		{
			
		}

		public function make(body:IBodyPresentation):SimplePhysicalProperties 
		{
			return null;
		}
	}
}
