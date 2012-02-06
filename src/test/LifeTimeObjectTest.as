/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:04
 */
package {

import core.view.gameobject.LifeTimeGameObject;
import core.view.gameobject.config.GameobjectConfig;

public class LifeTimeObjectTest {

    [Test]
    public function creationTest():void {
        var config:GameobjectConfig = new GameobjectConfig(false);
        var lifeTimeObj:LifeTimeGameObject = new LifeTimeGameObject(config, null);
    }
}
}
