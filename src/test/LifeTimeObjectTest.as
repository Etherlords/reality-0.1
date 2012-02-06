/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:04
 */
package {

import core.view.gameobject.LifeTimeGameObject;
import core.view.gameobject.config.GameobjectConfig;

import org.flexunit.asserts.assertEquals;

public class LifeTimeObjectTest {

    private var _lifeTimeObj:LifeTimeGameObject;

    [Before]
    public function setUp():void {
        var config:GameobjectConfig = new GameobjectConfig(false);
        _lifeTimeObj = new LifeTimeGameObject(config, null);
    }

    [Test]
    public function creationTest():void {
        assertEquals(0, _lifeTimeObj.lifeTime);
    }

    [Test]
    public function addingLifeTimeTest():void {
        _lifeTimeObj.preRender(10);
        assertEquals(10, _lifeTimeObj.lifeTime)
    }
}
}
