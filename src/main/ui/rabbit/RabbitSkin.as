/**
 * author: chaos-encoder
 * Date: 01.02.12 Time: 7:47
 */
package ui.rabbit {
import core.GlobalConstants;
import core.view.skin.AnimatedSprite;
import core.view.skin.Skin;

public class RabbitSkin extends Skin {
    
	private var left:DragonWalkLeft;
    private var right:DragonWalkRight;
    private var jumpRight:DragonFlyRight;
    private var jumpLeft:DragonFlyLeft;
	
    public function RabbitSkin() {
		super();
        addChild(new AnimatedSprite());
        left = new DragonWalkLeft();
        right = new DragonWalkRight();
        jumpRight = new DragonFlyRight();
        jumpLeft = new DragonFlyLeft();
        left.visible = false;
        right.visible = false;
        jumpRight.visible = false;
        jumpLeft.visible = false;
        addChild(left);
        addChild(right);
        addChild(jumpRight);
        addChild(jumpLeft);
    }


    override public function get phsyHeight():Number {
        return 50;
    }


    override public function get phsyWidth():Number {
        return 90;
    }

    override public function doAction(actionKey:uint):void {
        super.doAction(actionKey);
        left.visible       = (actionKey == GlobalConstants.ACTION_VIEW_WALK_LEFT);
        right.visible      = (actionKey == GlobalConstants.ACTION_VIEW_WALK_RIGHT);
        jumpRight.visible  = (actionKey == GlobalConstants.ACTION_VIEW_JUMP_RIGHT);
        jumpLeft.visible   = (actionKey == GlobalConstants.ACTION_VIEW_JUMP_LEFT);

        if (actionKey == GlobalConstants.ACTION_VIEW_FLAP_WINGS) {
            jumpLeft.flapWings();
            jumpRight.flapWings();
        }

    }
}
}

