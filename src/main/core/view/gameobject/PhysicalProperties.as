/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:26
 */
package core.view.gameobject {
import flash.geom.Point;

public interface PhysicalProperties {
    /**
     * Пока хз как сделать лучше но нужен контроль за ускорением временами
     * Хотя если инкапсулировать работу с боксом тут а наружу выдавать лишь интерфепйс
     * из поинтов и методов то ОК вроде
     */
    function stopXVelocity():void;

    function stopYVelocity():void;

    function applyImpulse(x:Number = 0, y:Number = 0, impulseSourceX:Number = 0, impulseSourceY:Number = 0):void;


    function get linearVelocity():Point;

    function set linearVelocity(linearVelocity:Point):void;

    function get physicBodyKey():*;
}
}
