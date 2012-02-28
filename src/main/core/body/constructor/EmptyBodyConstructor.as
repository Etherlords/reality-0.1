/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:11
 */
package core.body.constructor {
import core.body.IBodyPresentation;
import core.view.skin.Skin;


public class EmptyBodyConstructor implements IBodyConstructor {
    public function EmptyBodyConstructor() {
    }

    public function make(skin:Skin):IBodyPresentation {
       return new EmptyBody();
    }
}
}

import core.body.IBodyPresentation;
import flash.geom.Point;


class EmptyBody implements IBodyPresentation {

    public function get x():Number {
        return 0;
    }

    public function set x(value:Number):void {
    }

    public function get y():Number {
        return 0;
    }

    public function set y(value:Number):void {
    }

    public function get position():Point {
        return new Point();
    }

    public function set position(value:Point):void {
    }

    public function get width():Number {
        return 0;
    }

    public function set width(value:Number):void {
    }

    public function get height():Number {
        return 0;
    }

    public function set height(value:Number):void {
    }

    public function render():void {
    }

    public function preRender():void {
    }

    public function destroy():void {
    }
}