/**
 * author: chaos-encoder
 * Date: 26.03.12 Time: 22:16
 */
package ragevagon.enemy {
import core.view.skin.Skin;

import flash.display.MovieClip;

public class RageEnemySkin extends Skin {

    protected var waitSymbol:MovieClip;

    public function RageEnemySkin() {
        waitSymbol = new WaitingEnemySymbol();

        addChild(waitSymbol);
    }

    override public function get phsyHeight():Number
    {
        return waitSymbol.height;
    }

    override public function get phsyWidth():Number
    {
        return waitSymbol.width;
    }

}
}
