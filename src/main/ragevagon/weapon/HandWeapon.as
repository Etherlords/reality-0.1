/**
 * author: chaos-encoder
 * Date: 02.04.12 Time: 9:22
 */
package ragevagon.weapon {
import core.GlobalConstants;

public class HandWeapon extends Weapon {
    public function HandWeapon() {
    }
    override public function get key():String {
        return "hand";
    }

    override public function get viewKey():uint {
        return GlobalConstants.ACTION_VIEW_SWITCH_WEAPON_HAND;
    }
}
}
