/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:19
 */
package core.view.gameobject.physicalpropeties.constructor 
{
	import core.body.IBodyPresentation;
	import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

	public interface IPhysicalPropertiesConstructor 
	{
		function make(body:IBodyPresentation):SimplePhysicalProperties;
	}
}
