/**
 * author: chaos-encoder
 * Date: 17.03.12 Time: 8:40
 */
package ragevagon.constructor {
import Box2D.Dynamics.b2FilterData;
import Box2D.Dynamics.b2Fixture;

import core.Box2D.utils.Box2DWorldController;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;
import core.view.gameobject.physicalpropeties.SimplePhysicalProperties;

import flash.display.DisplayObjectContainer;

import ui.rabbit.constructor.PlayerConstructor;

public class RagePlayerConstructor extends PlayerConstructor {
    public function RagePlayerConstructor() {
    }

    public override function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject
    {
        var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
        //rabbitConfig.physicConfiguration.friction = 1;
        rabbitConfig.type = 2; //todo replace
        rabbitConfig.skinClass = RagePlayerSkin;
        var gameObject:GameObject = worldController.constructGameObject(RagePlayer, rabbitConfig, new PhysicModel(4,1,1),  stage);
        gameObject.physicalProperties.physicModel.fixedRotation = false;
        gameObject.body.x = 100;
        gameObject.body.y = 500 - gameObject.body.height;

        (gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey.SetAngularDamping(35);
        var fix:b2Fixture = (gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
        var filter:b2FilterData = new b2FilterData();
        filter.maskBits = 6;
        //filter.categoryBits = 0x0002;
        fix.SetFilterData(filter);

        gameObject.physicalProperties.physicBodyKey.SetSleepingAllowed(false);

        return gameObject;
    }
}
}

import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;
import core.view.skin.Skin;

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;
import flash.text.TextField;

class RagePlayer extends GameObject {

    function RagePlayer(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) {
        super(config, physicModel, instance, eventFlowTarget);
    }
}

class RagePlayerSkin extends Skin {
    private var label:TextField
    public function RagePlayerSkin(){
        label = new TextField();
        label.width = 60;
        label.height = 40;
        label.text = "rage skin";
        label.border = true;
        label.textColor = 0xffffff;
        label.borderColor = 0xffffff;
        addChild(label);
    }

    override public function get phsyHeight():Number
    {
        return label.width;
    }

    override public function get phsyWidth():Number
    {
        return label.height;
    }
}
