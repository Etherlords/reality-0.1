package core.view.direction 
{
	import core.services.ServicesLocator;
	import core.view.gameobject.GameObject;
	import flash.geom.Point;
	import ui.services.CameraService;
	/**
	 * ...
	 * @author 
	 */
	public class Direction 
	{
		private var _trackingObject:GameObject;
		public var velocity:Point;
		public var isJumping:Boolean;
		public var isFalling:Boolean;
		public var isWalking:Boolean;
		public var isLeftDiretion:Boolean;
		public var isRightDirection:Boolean;
		public var isStand:Boolean;
		
		public function Direction(trackingObject:GameObject = null) 
		{
			this.trackingObject = trackingObject;
			
		}
		
		public function get trackingObject():GameObject 
		{
			return _trackingObject;
		}
		
		public function set trackingObject(value:GameObject):void 
		{
			_trackingObject = value;
		}
		
		public function calcDirection():void
		{
			velocity = trackingObject.physicalProperties.physicModel.linearVelocity;
			
			analyzDirection();
		}
		
		private function analyzDirection():void 
		{
			if (Math.abs(velocity.y) > 0.2)
			{
				isJumping = velocity.y < 0.2;
				//isFalling = velocity.y > -0.2;
			}
			else
			{
				isJumping = false;
				isFalling = false;
			}
			
			if (Math.abs(velocity.x) > 0.2)
			{
				isWalking = true && !(isJumping || isFalling);
				isLeftDiretion = velocity.x < 0;
				isRightDirection = !isLeftDiretion;
			}
			else
			{
				isWalking = false;
			}
			
			var cameraService:CameraService = ServicesLocator.instance.getService(CameraService) as CameraService
			
			isWalking = isWalking && (cameraService.camera.target.y > 400);
			
			//TODO: захардкодил что если камера пондялавсь в воздух т.е заяц прыгнул то он не может стоять
			isStand = (!isWalking && !isJumping && !isFalling) && (cameraService.camera.target.y > 400);
			
		}
		
		
	}

}