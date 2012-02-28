/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:20
 */
package core.view.gameobject.physicalpropeties.constructor 
{
	import core.body.IBodyPresentation;
	import core.body.PhysicBodyPresentation;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

	public class SimplePhysicalPropertiesConstructor implements IPhysicalPropertiesConstructor 
	{
		public function SimplePhysicalPropertiesConstructor() 
		{
		}

		public function make(body:IBodyPresentation):SimplePhysicalProperties 
		{
			return new SimplePhysicalProperties(body as PhysicBodyPresentation);
		}
	}
}
