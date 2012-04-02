/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:09
 */
package ragevagon.scene.gameInteractionScene {
import Box2D.Dynamics.Controllers.b2BuoyancyController;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
import core.camera.Camera;
import core.events.GameObjectPhysicEvent;
import core.locators.PhysicWorldLocator;
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;
import core.view.gameobject.GameObject;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.physicalpropeties.PhysicModel;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import ragevagon.constructor.RagePlayerConstructor;
import ragevagon.enemy.RageEnemy;
import ragevagon.enemy.RageEnemySkin;
import ragevagon.player.RagePlayer;
import ragevagon.weapon.HandWeapon;
import ragevagon.weapon.ValeraWeapon;
import ragevagon.weapon.Weapon;

import ui.BulletSkin;
import ui.rabbit.logic.PlayerControllerShooter;
import ui.services.CameraService;

import utils.BoundariesConstructor;

public class GameRageVagonSceneController extends AbstractSceneController {

    private var worldController:Box2DWorldController;
    private var sceneView:RageVagonGameSceneView;
    private var _boundaries:BoundariesConstructor;
    private var controller:b2BuoyancyController;
    private var _playerController:PlayerControllerShooter;

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

        ServicesLocator.cameraService.cameraTarget = _playerController.player.body;
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


    private var _valeraWeapon:ValeraWeapon = new ValeraWeapon(addBullet);
    private var _handWeapon:HandWeapon = new HandWeapon();

    private function createViewComponents():void
    {
        _boundaries = new BoundariesConstructor();
        _boundaries.createBoundaries(sceneView.gameObjectsInstance, worldController);

        _playerController = new PlayerControllerShooter(sceneView.gameObjectsInstance, worldController,  new RagePlayerConstructor());
        var enemy:GameObject = make(sceneView.gameObjectsInstance, worldController);
        _playerController.addEventListener(GlobalConstants.EVENT_TYPE_SHOT_REQUEST, shotRequestHandler);

        setCurrentWeapon(_valeraWeapon);
    }

    private function setCurrentWeapon(weapon:Weapon):void {
        player.weapon = weapon;
        sceneView._weaponSwitcher.setWeapon(player.weapon.key);
        _playerController.player.applyActionView(player.weapon.viewKey);
    }


    private function shotRequestHandler(e:Event):void {
        player.applyActionView(GlobalConstants.ACTION_VIEW_ATTACK);
        player.weapon.shot();
        //addBullet();
    }

    protected function get player():RagePlayer {
        return _playerController.player as RagePlayer;;
    }

    protected function addBullet():void
    {
        var bulletConfig:GameobjectConfig = new GameobjectConfig();
        //bulletConfig.shapeType = 1;
        bulletConfig.type = 2;
        bulletConfig.skinClass = BulletSkin;
        var bullet:GameObject = worldController.constructGameObject(GameObject, bulletConfig, new PhysicModel(150,0,0), sceneView.gameObjectsInstance);
        //(bullet.physicalProperties as SimplePhysicalProperties).physicBodyKey.SetAngularDamping(35);
        //var fix:b2Fixture = (bullet.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
        //var filter:b2FilterData = new b2FilterData();
        //filter.maskBits = 5;
        //filter.categoryBits = 0x0002;
        //fix.SetFilterData(filter)

        bullet.body.x = player.body.x + player.body.width / 2;
        bullet.body.y = player.body.y + player.body.height / 2 - 50;
        var direction:Number = player.direction.isRightDirection ? 1 : -1;
        bullet.physicalProperties.applyImpulse(150 * direction, -1*Math.random() * 10+Math.random() * 10);
        bullet.addEventListener(GameObjectPhysicEvent.COLLIDE, collideWithBulletReaction);

    }

    private function collideWithBulletReaction(e:GameObjectPhysicEvent):void {
        //if (e.interactionWith is RageEnemy)
        {
            trace("hit "+e.interactionWith);
            (e.target as GameObject).markToDestroy = true;
            //e.interactionWith.applyActionView(GlobalConstants.ACTION_VIEW_DEAD_AFTER_BULLET_HIT);
        }
    }



    public function make(stage:DisplayObjectContainer, worldController:Box2DWorldController):GameObject
    {
        var enemyConfig:GameobjectConfig = new GameobjectConfig(true);
        //enemyConfig.physicConfiguration.friction = 1;
        enemyConfig.type = 2; //todo replace
        enemyConfig.skinClass = RageEnemySkin;
        var gameObject:GameObject = worldController.constructGameObject(RageEnemy, enemyConfig, new PhysicModel(0,1,0.5),  stage);
        //gameObject.physicalProperties.physicModel.fixedRotation = false;
        gameObject.body.x = 500;
        gameObject.body.y = 500 - gameObject.body.height;

        //(gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey.SetAngularDamping(100);
        /*var fix:b2Fixture = (gameObject.physicalProperties as SimplePhysicalProperties).physicBodyKey.GetFixtureList();
        var filter:b2FilterData = new b2FilterData();
        filter.maskBits = 6;
        //filter.categoryBits = 0x0002;
        fix.SetFilterData(filter);
        */
        gameObject.physicalProperties.physicBodyKey.SetSleepingAllowed(false);

        return gameObject;
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
        sceneView = new RageVagonGameSceneView();
        sceneView.addEventListener("switchWeaponRequest", switchWeaponRequestHandler);
        setViewComponent(sceneView);
        super.activate(instance);

        postInitilize();

    }

    public function switchWeaponRequestHandler(e:Event):void {
        if (player.weapon is ValeraWeapon) {
            setCurrentWeapon(_handWeapon);
        } else {
            setCurrentWeapon(_valeraWeapon);
        }







    }

}
}
