/**
 * Created by IntelliJ IDEA.
 * User: DES
 * Date: 31.01.12
 * Time: 8:22
 * To change this template use File | Settings | File Templates.
 */
package core.Box2D.utils {
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import core.GlobalConstants;

import flash.display.DisplayObject;


import flash.display.Stage;

public class RabbitBodyConstructor extends BasePhysicBodyConstructor {

    public function RabbitBodyConstructor(stage:Stage) {

        super();

        var circleDef:b2BodyDef = _bodyModel;
        circleDef.type = b2Body.b2_dynamicBody;
        circleDef.position.Set(100 * GlobalConstants.PIXELS_TO_METR, 580 * GlobalConstants.PIXELS_TO_METR);
        _shape = new b2CircleShape(10 * GlobalConstants.PIXELS_TO_METR);
        var circleShape:b2CircleShape = _shape as b2CircleShape;
        var circleFixture:b2FixtureDef = _fixtureModel;

        circleFixture.shape = circleShape;

        circleDef.fixedRotation = false;
        circleFixture.density = 0;
        circleFixture.friction = 0.4;
        circleFixture.restitution = 0;
        circleDef.position.Set(Math.random() * stage.stageWidth * GlobalConstants.PIXELS_TO_METR, 15 * GlobalConstants.PIXELS_TO_METR);

        _fixtureModel.shape = _shape;
        _body.CreateFixture(_fixtureModel);
    }
}
}
