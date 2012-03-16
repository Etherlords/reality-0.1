package core.Box2D.utils 
{
import Box2D.Dynamics.b2Body;

import core.view.gameobject.GameObject;

import org.as3commons.collections.Map;

/**
	 * ...
	 * @author 
	 */
	public class GameobjectsRegistry 
	{
		
		private var gameObjectsList:Vector.<GameObject>
		
		private var phyBodyToGameobjectMap:Map
		
		public function GameobjectsRegistry() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			gameObjectsList = new Vector.<GameObject>;
			phyBodyToGameobjectMap = new Map();
		}
		
		
		public function getGameObjectBy_b2body(b2body:b2Body):GameObject
		{
			return phyBodyToGameobjectMap.itemFor(b2body);
		}
		
		public function unRegisterGameObject(gameObject:GameObject):void
		{
			for (var i:int = 0; i < gameObjectsList.length; i++)
			{
				if (gameObjectsList[i] == gameObject)
				{
					gameObjectsList.splice(i, 1);
					break;
				}
			}
			
			if(gameObject.physicalProperties)
				phyBodyToGameobjectMap.remove(gameObject);
		}
		
		public function registerGameObject(gameObject:GameObject):void
		{
			gameObjectsList.push(gameObject);
			
			if(gameObject.physicalProperties)
				phyBodyToGameobjectMap.add(gameObject.physicalProperties.physicBodyKey, gameObject);
		}
		
		public function get objectsList():Vector.<GameObject> 
		{
			return gameObjectsList;
		}
		
	}

}