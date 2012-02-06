package {
//import com.sociodox.theminer.TheMiner;

import core.Box2D.utils.Box2DWorldController;
import core.GlobalConstants;
import core.events.GameObjectPhysicEvent;
import core.locators.PhysicWorldLocator;
import core.view.gameobject.config.GameobjectConfig;
import core.view.skin.EmptyBoxSkin;

import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import patterns.strategy.Strategy;
import patterns.strategy.StrategyController;

import ui.Bell;
import ui.rabbit.FlapTriggerGameObject;
import ui.rabbit.Rabbit;
import ui.rabbit.RabbitSkin;
import ui.rabbit.rabbitReactions.RabbitAccelerate;
import ui.rabbit.rabbitReactions.RabbitFlapWings;
import ui.rabbit.rabbitReactions.RabbitFlowMouse;
import ui.rabbit.rabbitReactions.RabbitStandarJump;

import utils.BoundariesConstructor;

/**
 * ...
 * @author
 */
public class GameScene extends Sprite {
    private var worldConstructor:Box2DWorldController;
    private var gameObject:Rabbit;
    private var rabbitReactions:StrategyController;
    private var bell:Bell;

    private var gameObjects:Array;
    private var _boundaries:BoundariesConstructor;

    public function GameScene() {
        super();
        //this.addChild(new TheMiner(true));
        initilize();
    }

    private function initilize():void {
        gameObjects = [];
        createWorld();
        createViewComponents();
        manageEvents();

        var stepTimer:Timer = new Timer(0.025 * 1000);
        stepTimer.addEventListener(TimerEvent.TIMER, gameStep);
        stepTimer.start();

        var updateRabbitMoveTimer:Timer = new Timer(100);
        updateRabbitMoveTimer.addEventListener(TimerEvent.TIMER, calculateObjectMoving);
        updateRabbitMoveTimer.start();

        var generateBellTimer:Timer = new Timer(3000);
        generateBellTimer.addEventListener(TimerEvent.TIMER, generateBell);
        generateBellTimer.start();

        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
    }

    private function mouseDownHandler(event:MouseEvent):void {
        rabbitAction(GlobalConstants.ACTION_STRATEGY_FLAP_WINGS);
    }

    private function keyDownHandler(event:KeyboardEvent):void {
        rabbitAction(GlobalConstants.ACTION_STRATEGY_FLAP_WINGS);
    }

    private function generateBell(event:TimerEvent):void {
        createBell();
    }

    private function calculateObjectMoving(e:* = null):void {
        rabbitAction(GlobalConstants.ACTION_STRATEGY_FOLLOW_MOUSE);
    }

    private function manageEvents():void {
        stage.addEventListener(MouseEvent.CLICK, jumpAction);
    }

    private function jumpAction(e:MouseEvent):void {
        rabbitAction(GlobalConstants.ACTION_STRATEGY_JUMP, 2);
    }

    private function rabbitAction(key:String, ...rest):void {
        rest.unshift(gameObject);

        rabbitReactions.execute(key, rest);
    }

    private function createWorld():void {
        worldConstructor = new Box2DWorldController(new Point(0, 10), this, true);
        //trace(PhysicWorldLocator.instance);
        PhysicWorldLocator.instance.world = worldConstructor.world;
    }

    private function createViewComponents():void {
        //Проблема что все объекты должны получать рендер/пререндер поэтому их нужно как тозаносить в обищй пулл
        //Пока хз как это лучше сделать.
        //Думаю можно сделать фабрику для создания конкретно сконфигурированых объектов factory.make(rabbit), factory.make(denisok)
        //и эта фектори уже будет так же работать с пулом
        var rabbitConfig:GameobjectConfig = new GameobjectConfig(true);
        rabbitConfig.physicConfiguration.type = 2; //todo replace
        rabbitConfig.skinClass = RabbitSkin;
        gameObject = worldConstructor.constructGameObject(Rabbit, rabbitConfig, this) as Rabbit;

        gameObject.body.x = 500;
        gameObject.body.y = 500;

        gameObject.addEventListener(GameObjectPhysicEvent.COLLIDE, rabbitColideWith);

        var flapTrigger:FlapTriggerGameObject = worldConstructor.constructGameObject(FlapTriggerGameObject, new GameobjectConfig(false), this) as FlapTriggerGameObject;

        worldConstructor.registerGameObject(gameObject);

        _boundaries = new BoundariesConstructor();
        _boundaries.createBoundaries();

        rabbitReactions = new StrategyController();
        var standarJump:Strategy = new Strategy(GlobalConstants.ACTION_STRATEGY_JUMP, new RabbitStandarJump());
        var followMouse:Strategy = new Strategy(GlobalConstants.ACTION_STRATEGY_FOLLOW_MOUSE, new RabbitFlowMouse(stage));

        rabbitReactions.addStrategy(standarJump);
        rabbitReactions.addStrategy(followMouse);
        rabbitReactions.addStrategy(new Strategy(GlobalConstants.ACTION_STRATEGY_ACCELERATE, new RabbitAccelerate()));
        rabbitReactions.addStrategy(new Strategy(GlobalConstants.ACTION_STRATEGY_FLAP_WINGS, new RabbitFlapWings(flapTrigger)));
    }

    private function rabbitColideWith(e:GameObjectPhysicEvent):void {
        trace('collide with', e.target, e.interactionWith);
        rabbitAction(GlobalConstants.ACTION_STRATEGY_ACCELERATE);
        worldConstructor.destroyGameObject(e.interactionWith);

    }

    private function createBell():void {
        var bellConfig:GameobjectConfig = new GameobjectConfig(true);
        bellConfig.physicConfiguration.type = 2; //todo replace
        bellConfig.skinClass = EmptyBoxSkin;
        bell = worldConstructor.constructGameObject(Bell, bellConfig, this) as Bell;// new Bell(bellConfig, this);
        bell.body.x = Math.random() * _boundaries.width;
        bell.body.y = 0;

        // worldConstructor.registerGameObject(bell);
    }


    /**
     * Игровая итерация. Тут гейм обжекты должны получить пре рендер чтобы зкаомитить
     * парамтеры в физический движок и рендер чтобы вызвать применение парамтеров физической модели к
     * графике
     * @param    e
     */
    private function gameStep(e:* = null):void {
        worldConstructor.gameStep();
    }

}

}