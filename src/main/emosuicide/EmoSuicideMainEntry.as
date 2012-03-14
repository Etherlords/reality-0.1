/**
 * author: chaos-encoder
 * Date: 21.02.12 Time: 20:06
 */
package emosuicide {
import core.locators.ServicesLocator;
import core.states.State;
import core.states.StatesManager;
import core.states.config.StateConfig;

import emosuicide.scene.gameInteractionScene.GameSuicideSceneController;

import flash.display.Sprite;

import ui.services.scores.ScoresService;
import ui.services.scores.store.AbstractScoresStorageService;

public class EmoSuicideMainEntry extends Sprite {
    public function EmoSuicideMainEntry() {
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

        var gameStateConfig:StateConfig = new StateConfig('Game', GameSuicideSceneController);
        var gameState:State = new State(gameStateConfig);


        stateManager.nextState(gameState);

        stateManager.start();
    }

}
}
