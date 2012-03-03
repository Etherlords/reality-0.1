/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:09
 */
package emosuicide.scene.gameInteractionScene {
import Box2D.Dynamics.Controllers.b2BuoyancyController;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
import core.events.GameObjectPhysicEvent;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;

import emosuicide.emo.emoReactions.ExposeOnFloorReaction;

import flash.display.DisplayObjectContainer;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import patterns.strategy.Strategy;

import ui.rabbit.logic.RabbitController;
import ui.scene.gameInteractionScene.view.GameSceneView;
import ui.services.CameraService;

import utils.BoundariesConstructor;

public class GameSuicideSceneController extends AbstractSceneController {

    private var worldController:Box2DWorldController;
    private var sceneView:GameSceneView;
    private var _boundaries:BoundariesConstructor;
    private var controller:b2BuoyancyController;
    private var _rabbitController:RabbitController;

    public function GameSuicideSceneController()
    {
        super();
    }

    override protected function initilize():void
    {
        //create using services
        ServicesLocator.instance.addService(new CameraService());

        super.initilize();
    }

    private function postInitilize():void
    {
        createWorld();
        createViewComponents();

        initilizeBuoyancyController();

        initGameInitrations();

        ServicesLocator.cameraService.cameraTarget = _rabbitController.rabbit.body;
    }

    private function initGameInitrations():void {
            /*
            var overtimeObjectGeneration:Timer = new Timer(300);
            overtimeObjectGeneration.addEventListener(TimerEvent.TIMER, triggerOvertimeObjectGeneration);
            overtimeObjectGeneration.start(); */

            var stepTimer:Timer = new Timer(0.025 * 1000);
            stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
            stepTimer.start();
    }

    private function gameStep(e:TimerEvent):void
    {
        worldController.gameStep();
        sceneView.render();
    }

    private function createWorld():void
    {
        worldController = new Box2DWorldController(new Point(0, 10), sceneView.gameObjectsInstance, false);

        PhysicWorldLocator.instance.world = worldController.world;
    }



    private function createViewComponents():void
    {
        _boundaries = new BoundariesConstructor();
        _boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);

        _boundaries.floor.addEventListener(GameObjectPhysicEvent.COLLIDE, onFallOnFloor);

        _rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController);
        _rabbitController.rabbitActionsHelper.behaviorStrategyController.addStrategy(new Strategy(GlobalConstants.ACTION_STRATEGY_EXPOSE_ON_FLOOR, new ExposeOnFloorReaction));

        //rabbitController = new RabbitController(sceneView.gameObjectsInstance, worldController);

        //rabbitController.rabbit.addEventListener(GameObjectPhysicEvent.COLLIDE, onRabbitColide);
    }

    private function initilizeBuoyancyController():void
    {
        controller = new b2BuoyancyController();


        controller.normal.Set(0, -1);
        controller.offset = 100000 * GlobalConstants.PIXELS_TO_METR;
        controller.density = 2.0;
        //controller.useWorldGravity = false
        //controller.useDensity = true;
        controller.linearDrag = 5;
        //controller.angularDrag = 2;


        worldController.addController(controller, 'nullGravityField');

        //controller.AddBody(rabbitController.rabbit.physicalProperties.physicBodyKey);
    }

    private function onFallOnFloor(event:GameObjectPhysicEvent):void {
        //todo add suicide here
        //trace("collide with floor " + event.interactionWith.physicalProperties.linearVelocity.y);
        if (_rabbitController.rabbit == event.interactionWith) {
            _rabbitController.rabbitActionsHelper.rabbitAction(GlobalConstants.ACTION_STRATEGY_EXPOSE_ON_FLOOR);
        }
    }



    public override function activate(instance:DisplayObjectContainer):void
    {
        sceneView = new GameSceneView();
        setViewComponent(sceneView);
        super.activate(instance);

        postInitilize();

    }

}
}
