/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:06
 */
package ragevagon {
import core.locators.ServicesLocator;
import core.states.State;
import core.states.StatesManager;
import core.states.config.StateConfig;

import ragevagon.scene.gameInteractionScene.GameRageVagonSceneController;

import flash.display.Sprite;

import ui.services.scores.ScoresService;
import ui.services.scores.store.AbstractScoresStorageService;

public class RageVagonMainEntry extends Sprite {
    public function RageVagonMainEntry() {
        initilzie();
    }

    private function initilzie():void
    {
        createScenes();
    }

    private function createScenes():void
    {
        var stateManager:StatesManager = new StatesManager(this);

        ServicesLocator.instance.addService(new AbstractScoresStorageService())
        ServicesLocator.instance.addService(new ScoresService());

        var gameStateConfig:StateConfig = new StateConfig('Game', GameRageVagonSceneController);
        var gameState:State = new State(gameStateConfig);


        stateManager.nextState(gameState);

        stateManager.start();
    }

}
}
