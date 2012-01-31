/**
 * Created by IntelliJ IDEA.
 * User: DES
 * Date: 31.01.12
 * Time: 8:23
 * To change this template use File | Settings | File Templates.
 */
package core.Box2D.utils {
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;

public interface BodyConstructor {

    function get bodyModel():b2BodyDef;
    function get shape():b2Shape;
    function get fixtureModel():b2FixtureDef;
    function get body():b2Body;

}
}
