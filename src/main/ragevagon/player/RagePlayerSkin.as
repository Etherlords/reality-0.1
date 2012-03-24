/**
 * author: chaos-encoder
 * Date: 22.03.12 Time: 21:55
 */
package ragevagon.player {

import core.view.direction.Direction;
import core.view.skin.Skin;

public class RagePlayerSkin extends Skin {

    private var playerWithHandWeapon:PlayerWithWeaponSkin;
    private var currentPlayerSkin:Skin;

    public function RagePlayerSkin() {
        playerWithHandWeapon = new PlayerWithWeaponSkin(new WaitingPlayerSymbol(), new BookAttackPlayerSymbol() );
        currentPlayerSkin = playerWithHandWeapon;
        addChild(currentPlayerSkin);
    }

    override public function set direction(value:Direction):void {
        super.direction = value;
        currentPlayerSkin.direction = value;
    }    
    
    override public function get phsyHeight():Number
    {
        return currentPlayerSkin.height;
    }

    override public function get phsyWidth():Number
    {
        return currentPlayerSkin.width;
    }


    override public function doAction(actionKey:uint):void {
        currentPlayerSkin.doAction(actionKey);
    }

}
}

import core.GlobalConstants;
import core.view.skin.Skin;

import flash.display.MovieClip;
import flash.events.Event;

class PlayerWithWeaponSkin extends Skin {

    private var waitingSkin:MovieClip;
    private var walkingSkin:MovieClip;
    private var attackSkin:MovieClip;

    public function PlayerWithWeaponSkin(waitingSkin:MovieClip, attackSkin:MovieClip){
        this.waitingSkin = waitingSkin;
        waitingSkin.visible = true;
        addChild(waitingSkin);

        walkingSkin = new WalkPlayerSymbol();
        walkingSkin.visible = false;
        addChild(walkingSkin);

        this.attackSkin = attackSkin;
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
