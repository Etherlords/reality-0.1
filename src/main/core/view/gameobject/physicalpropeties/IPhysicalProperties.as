/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:26
 */
package core.view.gameobject.physicalpropeties 
{
	import flash.geom.Point;

	public interface IPhysicalProperties 
	{
		
		function stopXVelocity():void;

		function stopYVelocity():void;

		function applyImpulse(x:Number = 0, y:Number = 0, impulseSourceX:Number = 0, impulseSourceY:Number = 0):void;
		
		function applyForce(x:Number = 0, y:Number = 0, forceSourceX:Number = 0, forceSourceY:Number = 0):void;

		function get physicModel():PhysicModel;

		function get physicBodyKey():*;
	}
}
