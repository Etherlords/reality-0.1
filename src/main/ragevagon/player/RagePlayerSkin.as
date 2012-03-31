/**
 * author: chaos-encoder
 * Date: 22.03.12 Time: 21:55
 */
package ragevagon.player {

import core.GlobalConstants;
import core.view.direction.Direction;
import core.view.skin.Skin;

public class RagePlayerSkin extends Skin {

    protected var playerWithHandWeapon:PlayerWithWeaponSkin;
    protected var playerWithValeraWeapon:PlayerWithWeaponSkin;
    protected var _currentPlayerSkin:Skin;

    public function RagePlayerSkin() {
        playerWithHandWeapon = new PlayerWithWeaponSkin(new WaitingPlayerSymbol(), new WalkPlayerSymbol(), new BookAttackPlayerSymbol());
        playerWithValeraWeapon = new PlayerWithWeaponSkin(new PlayerWithValeraSymbol(), new LordWalkPlayerSymbol(), new PlayerWithValeraAttackSymbol());
        currentPlayerSkin = playerWithHandWeapon;

    }

    override public function set direction(value:Direction):void {
        super.direction = value;
        _currentPlayerSkin.direction = value;
    }    
    
    override public function get phsyHeight():Number
    {
        return _currentPlayerSkin.height;
    }

    override public function get phsyWidth():Number
    {
        return _currentPlayerSkin.width;
    }


    override public function doAction(actionKey:uint):void {
        if (actionKey == GlobalConstants.ACTION_VIEW_SWITCH_WEAPON_HAND) {
            currentPlayerSkin = playerWithHandWeapon;
        } else if (actionKey == GlobalConstants.ACTION_VIEW_SWITCH_WEAPON_VALERA) {
            currentPlayerSkin = playerWithValeraWeapon;
        }
        currentPlayerSkin.doAction(actionKey);
    }

    public function get currentPlayerSkin():Skin {
        return _currentPlayerSkin;
    }

    public function set currentPlayerSkin(value:Skin):void {
        if (_currentPlayerSkin == value) {
            return;
        }
        if (_currentPlayerSkin) {
            removeChild(_currentPlayerSkin);
        }
        _currentPlayerSkin = value;
        _currentPlayerSkin.direction = direction;
        addChild(_currentPlayerSkin);
    }
}
}

import core.GlobalConstants;
import core.view.skin.Skin;

import flash.display.MovieClip;

class PlayerWithWeaponSkin extends Skin {

    private var waitingSkin:MovieClip;
    private var walkingSkin:MovieClip;
    private var attackSkin:MovieClip;

    public function PlayerWithWeaponSkin(waitingSkin:MovieClip, walkingSkin:MovieClip, attackSkin:MovieClip){
        this.waitingSkin = waitingSkin;
        waitingSkin.visible = true;
        addChild(waitingSkin);

        this.walkingSkin = walkingSkin;
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

        if ((actionKey == GlobalConstants.ACTION_VIEW_ATTACK)) {
            if (waitingSkin.visible) {
                waitingSkin.playAttack();
            } else if (walkingSkin.visible) {
                walkingSkin.playAttack();
            }
            //waitingSkin.visible = walkingSkin.visible = false;
        } else {
            attackSkin.visible = false;
            waitingSkin.visible = !direction.isWalking;
            walkingSkin.visible = direction.isWalking;
        }
    }

}
