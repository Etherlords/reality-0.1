/**
 * author: chaos-encoder
 * Date: 31.01.12 Time: 8:38
 */
package core.Box2D.utils {

import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import core.GlobalConstants;
import core.locators.PhysicWorldLocator;
import core.view.gameobject.config.PhysicConfiguration;

public class BasePhysicBodyConstructor implements BodyConstructor {

    protected var _bodyModel:b2BodyDef = new b2BodyDef();
    protected var _shape:b2Shape = new b2PolygonShape();
    protected var _fixtureModel:b2FixtureDef = new b2FixtureDef();
    protected var _body:b2Body = PhysicWorldLocator.instance.world.CreateBody(_bodyModel);

    public function BasePhysicBodyConstructor() {
    }

    public function get shape():b2Shape {
        return _shape;
    }

    public function get bodyModel():b2BodyDef {
        return _bodyModel;
    }

    public function get fixtureModel():b2FixtureDef {
        return _fixtureModel;
    }

    public function get body():b2Body {
        return _body;
    }
}
}
