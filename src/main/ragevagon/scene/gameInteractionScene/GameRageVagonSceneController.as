/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:09
 */
package ragevagon.scene.gameInteractionScene {
import Box2D.Dynamics.Controllers.b2BuoyancyController;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
import core.camera.Camera;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;

import flash.display.DisplayObjectContainer;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import ragevagon.constructor.RagePlayerConstructor;

import ui.rabbit.logic.PlayerControllerShooter;
import ui.scene.gameInteractionScene.view.GameSceneView;
import ui.services.CameraService;

import utils.BoundariesConstructor;

public class GameRageVagonSceneController extends AbstractSceneController {

    private var worldController:Box2DWorldController;
    private var sceneView:GameSceneView;
    private var _boundaries:BoundariesConstructor;
    private var controller:b2BuoyancyController;
    private var _rabbitController:PlayerControllerShooter;

    public function GameRageVagonSceneController()
    {
        super();
    }

    override protected function initilize():void
    {
        //create using services
        var camera:Camera = new Camera();
        camera.target.y = 500;
        ServicesLocator.instance.addService(new CameraService(camera));

        super.initilize();
    }

    private function postInitilize():void
    {
        createWorld();
        createViewComponents();

        initilizeBuoyancyController();

        initGameInitrations();

        ServicesLocator.cameraService.cameraTarget = _rabbitController.player.body;
    }

    private function initGameInitrations():void {
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

        _rabbitController = new PlayerControllerShooter(sceneView.gameObjectsInstance, worldController,  new RagePlayerConstructor());
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
