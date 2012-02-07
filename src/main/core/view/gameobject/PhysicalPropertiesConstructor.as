/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:19
 */
package core.view.gameobject {
import core.body.IBodyPresentation;

public interface PhysicalPropertiesConstructor {
    function make(body:IBodyPresentation):SimplePhysicalProperties;
}
}
