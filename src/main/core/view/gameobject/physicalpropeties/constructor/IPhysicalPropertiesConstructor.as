/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:19
 */
package core.view.gameobject.physicalpropeties.constructor 
{

	import core.view.gameobject.body.IBodyPresentation;
	import core.view.gameobject.physicalpropeties.PhysicModel;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

	public interface IPhysicalPropertiesConstructor 
	{
		function make(body:IBodyPresentation, physicModel:PhysicModel):SimplePhysicalProperties;
	}
}
