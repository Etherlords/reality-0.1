/**
 * author: chaos-encoder
 * Date: 02.04.12 Time: 9:22
 */
package ragevagon.weapon {
import core.GlobalConstants;

public class ValeraWeapon extends Weapon {
    private var shotHandler:Function;
    public function ValeraWeapon(shotHandler:Function) {
        this.shotHandler = shotHandler;
    }


    override public function get key():String {
        return "valera";
    }


    override public function get viewKey():uint {
        return GlobalConstants.ACTION_VIEW_SWITCH_WEAPON_VALERA;
    }


    override public function shot():void {
        shotHandler();
    }
}
}
