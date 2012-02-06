/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:24
 */
package core.Box2D.utils {
import core.body.IBodyPresentation;
import core.view.gameobject.PhysicalPropertiesConstructor;
import core.view.gameobject.SimplePhysicalProperties;

public class EmptyPhysicalPropertiesConstructor implements PhysicalPropertiesConstructor {
    public function EmptyPhysicalPropertiesConstructor() {
    }

    public function make(body:IBodyPresentation):SimplePhysicalProperties {
        return null;
    }
}
}

import core.body.PhysicBodyPresentation;
import core.view.gameobject.PhysicalProperties;

import flash.geom.Point;

class EmptyPhysicalProperties implements PhysicalProperties {

    function EmptyPhysicalProperties(body:PhysicBodyPresentation) {

    }

    public function stopXVelocity():void {
    }

    public function stopYVelocity():void {
    }

    public function applyImpulse(x:Number = 0, y:Number = 0, impulseSourceX:Number = 0, impulseSourceY:Number = 0):void {
    }

    public function get linearVelocity():Point {
        return new Point();
    }

    public function set linearVelocity(linearVelocity:Point):void {
    }

    public function get physicBodyKey():* {
        return null;
    }
}
