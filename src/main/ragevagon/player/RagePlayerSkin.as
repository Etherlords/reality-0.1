/**
 * author: chaos-encoder
 * Date: 22.03.12 Time: 21:55
 */
package ragevagon.player {

import core.GlobalConstants;
import core.view.skin.Skin;

import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

public class RagePlayerSkin extends Skin {
    private var label:TextField;
    private var waitingSkin:MovieClip;
    private var walkingSkin:MovieClip;
    private var attackSkin:MovieClip;

    public function RagePlayerSkin(){
        label = new TextField();
        label.width = 60;
        label.height = 40;
        label.text = "rage skin";
        label.border = true;
        label.textColor = 0xffffff;
        label.borderColor = 0xffffff;
        addChild(label);
        waitingSkin = new WaitingPlayerSymbol();
        waitingSkin.visible = true;
        addChild(waitingSkin);

        walkingSkin = new WalkPlayerSymbol();
        walkingSkin.visible = false;
        addChild(walkingSkin);

        attackSkin = new BookAttackPlayerSymbol();
        attackSkin.visible = false;
        addChild(attackSkin);
    }

    override public function get phsyHeight():Number
    {
        return waitingSkin.height;
    }

    override public function get phsyWidth():Number
    {
        return waitingSkin.width;
    }


    override public function doAction(actionKey:uint):void {
        super.doAction(actionKey);

        if (attackSkin.visible) {
            return;
        }

        if ((actionKey == GlobalConstants.ACTION_VIEW_ATTACK)) {
            attackSkin.visible = true;
            attackSkin.play();
            attackSkin.addEventListener("finished", function (e:Event):void {
                attackSkin.visible = false;
                waitingSkin.visible = true;
            });
            waitingSkin.visible = walkingSkin.visible = false;
        } else {
            attackSkin.visible = false;
            waitingSkin.visible = !direction.isWalking;
            walkingSkin.visible = direction.isWalking;
        }
    }
}
}
