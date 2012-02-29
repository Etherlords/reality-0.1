/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:20
 */
package core.view.gameobject.physicalpropeties.constructor 
{

	import core.view.gameobject.body.IBodyPresentation;
	import core.view.gameobject.body.PhysicBodyPresentation;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;
	

	public class SimplePhysicalPropertiesConstructor implements IPhysicalPropertiesConstructor 
	{
		public function SimplePhysicalPropertiesConstructor() 
		{
		}

		public function make(body:IBodyPresentation, physicModel:PhysicModel):SimplePhysicalProperties 
		{
			return new SimplePhysicalProperties(body as PhysicBodyPresentation, physicModel);
		}
	}
}
