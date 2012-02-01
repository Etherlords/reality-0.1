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
    private var jump:DragonFlyRight;
    public function RabbitSkin() {
		super();
        addChild(new AnimatedSprite());
        left = new DragonWalkLeft();
        right = new DragonWalkRight();
        jump = new DragonFlyRight();
        left.visible = false;
        right.visible = false;
        jump.visible = false;
        addChild(left);
        addChild(right);
        addChild(jump);
    }


    override public function doAction(actionKey:uint):void {
        super.doAction(actionKey);
        left.visible = (actionKey == GlobalConstants.ACTION_VIEW_WALK_LEFT);
        right.visible = (actionKey == GlobalConstants.ACTION_VIEW_WALK_RIGHT);
        jump.visible = (actionKey == GlobalConstants.ACTION_VIEW_JUMP);

    }
}
}

