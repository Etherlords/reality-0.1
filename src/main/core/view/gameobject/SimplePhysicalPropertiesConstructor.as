/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:20
 */
package core.view.gameobject {
import core.body.IBodyPresentation;
import core.body.PhysicBodyPresentation;

public class SimplePhysicalPropertiesConstructor implements PhysicalPropertiesConstructor {
    public function SimplePhysicalPropertiesConstructor() {
    }

    public function make(body:IBodyPresentation):SimplePhysicalProperties {
        return new SimplePhysicalProperties(body as PhysicBodyPresentation);
    }
}
}
