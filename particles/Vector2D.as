package  
{	
	/**
	 * Vector2D
	 * Purpose: Utility class to assist in Vector manipulation in a 2D environment
	 * @author Shiu
	 * @version 1.0	9 August 2011
	 * @version 2.0	22 August 2011
	 */
	public class Vector2D 
	{
		private var _vecX:Number;
		private var _vecY:Number;
		
		/**
		 * Constructor of Vector2D
		 * @param	mc_x	x-component of vector
		 * @param	mc_y	y-component of vector
		 */
		public function Vector2D(mc_x:Number, mc_y:Number) 
		{
			this._vecX = mc_x;
			this._vecY = mc_y;
		}
		
		/**
		 * Provision for an alternate constructor
		 * @param	mag		Magnitude of vector
		 * @param	ang_rad Orientation of vector in radians
		 */
		public function polar (mag:Number, ang_rad:Number):void
		{
			this._vecX = mag*Math.cos(ang_rad);
			this._vecY = mag*Math.sin(ang_rad);
		}
		
		/**
		 * Accessors of individual x-component
		 */
		public function set x(new_x:Number):void
		{
			this._vecX = new_x;
		}
		
		public function get x ():Number
		{
			return this._vecX;
		}
		
		/**
		 * Accessors of individual y-component
		 */
		public function set y(new_y:Number):void
		{
			this._vecY = new_y;
		}
		
		public function get y ():Number
		{
			return _vecY;
		}
		
		/**
		 * Method to obtain the vector
		 * @return A vector array of x and y components
		 */
		public function getVector ():Vector.<Number>
		{
			return new <Number>[_vecX, _vecY]
		}
		
		/**
		 * Method to obtain current angle of vector
		 * @return Angle in radians
		 */
		public function getAngle ():Number 
		{
			return Math.atan2(_vecY, _vecX);
		}
		
		/**
		 * Method tl alter current angle of vector
		 * @param	ang_rad New angle for current vector in radians
		 */
		public function setAngle(ang_rad:Number):void
		{
			var mag_current:Number = this.getMagnitude();
			this.polar(mag_current, ang_rad);
		}
		
		/**
		 * Method to obtain current magnitude of vector
		 * @return Magnitude of type Number
		 */
		public function getMagnitude():Number
		{
			return Math.sqrt(_vecX * _vecX + _vecY * _vecY);
		}
		
		/**
		 * Method ot alter current magnitude of vector
		 * @param	magnitude New magnitude of vector
		 */
		public function setMagnitude(magnitude:Number):void
		{
			var ang_current:Number = this.getAngle();
			this.polar(magnitude, ang_current);
		}
		
		/**
		 * Method to invert both x and y components of vector
		 */
		public function invert():void
		{
			_vecX *= -1;
			_vecY *= -1;
		}
		
		/**
		 * Version 2.0
		 * Method to invert only the x-component of Vector2D
		 */
		public function invertX():void
		{
			_vecX *= -1;
		}
		
		/**
		 * Version 2.0
		 * Method to invert only the x-component of Vector2D
		 */
		public function invertY():void
		{
			_vecY *= -1;
		}
		
		/**
		 * Version 2.0
		 * Method to scale current vector by a scalar magnitude
		 * @param	multiplier A scalar number to mulitply current vector
		 */
		public function scale (magnitude:Number):void
		{
			_vecX *= magnitude;
			_vecY *= magnitude;
		}
		
		/**
		 * Method to generate a copy of current vector
		 * @return A copy of current vector
		 */
		public function clone ():Vector2D
		{
			var clone1:Vector2D = new Vector2D(_vecX, _vecY);
			return clone1;
		}
		
		/**
		 * Method to perform subtration on current vector
		 * @param	toMinus A vector to minus current vector
		 * @return A copy of subtration product
		 */
		public function minus(toMinus:Vector2D):Vector2D
		{
			var newX:Number = this._vecX - toMinus.x;
			var newY:Number = this._vecY - toMinus.y;
			return new Vector2D(newX, newY);
		}
		
		/**
		 * Method to perform addition on current vector
		 * @param	toAdd A vector to add onto current vector
		 * @return A copy of addition product
		 */
		public function add(toAdd:Vector2D):Vector2D
		{
			var newX:Number = this._vecX + toAdd.x;
			var newY:Number = this._vecY + toAdd.y;
			return new Vector2D(newX, newY);
		}
		
		/**
		 * Version 2.0
		 * Method to multiply current vector with a certain magnitude
		 * @param	multiplier
		 * @return A copy of the multiplied product
		 */
		public function multiply(multiplier:Number):Vector2D
		{
			var newX:Number = this._vecX * multiplier;
			var newY:Number = this._vecY * multiplier;
			return new Vector2D(newX, newY);
		}
		
		/**
		 * Method to rotate current vector
		 * @param	angle_rad Angle in radian to rotate current vector
		 * @param	offset A vector to offset current circular into an eliptical course
		 * @return A copy of the rotated vector
		 */
		public function rotate(angle_rad:Number):Vector2D
		{
			var newX:Number = _vecX * Math.cos(angle_rad) - _vecY * Math.sin(angle_rad);
			var newY:Number = _vecX * Math.sin(angle_rad) + _vecY * Math.cos(angle_rad);
			
			return new Vector2D(newX, newY);
		}
		
		/**
		 * Method to obtain vector unit of current vector
		 * @return A copy of normalised vector
		 */
		public function normalise():Vector2D
		{
			return new Vector2D(this._vecX/this.getMagnitude(), this._vecY/this.getMagnitude())
		}
		
		/**
		 * Method to perform dot product with another vector
		 * @param	vector2 A vector to perform dot product with current vector
		 * @return A scalar number of dot product
		 */
		public function dotProduct(vector2:Vector2D):Number
		{
			var componentX:Number = this._vecX * vector2.x;
			var componentY:Number = this._vecY * vector2.y;
			return componentX+componentY;
		}
		
		/**
		 * Method to perform vector product of current vector with input vector
		 * @param	vector2 A vector to perform vector product with current vector
		 * @return The magnitude of pseudo-vector on z-axis
		 */
		public function vectorProduct(vector2:Vector2D):Number 
		{
			return this._vecX * vector2.y - this._vecY * vector2.x;
		}
		
		/**
		 * Method to obtain the smaller angle, in radian, sandwiched from current vector to input vector
		 * @param	vector2 A vector to bound the angle
		 * @return Angle in radian, positive is clockwise, negative is anti-clockwise
		 */
		public function angleBetween(vector2:Vector2D):Number
		{	
			//get normalised vectors
			var norm1:Vector2D = this.normalise();
			var norm2:Vector2D = vector2.normalise();
			
			//dot product of vectors to find angle
			var product:Number = norm1.dotProduct(norm2);
			product = Math.min(1, product);
			var angle:Number = Math.acos(product);
			
			//sides of angle
			if (this.vectorProduct(vector2) < 0) angle *= -1
			return angle;
		}
		
		/**
		 * Method to obtain the projection of current vector on a given axis
		 * @param	axis An axis where vector is projected on
		 * @return The projection length of current vector on given axis
		 */
		public function projectionOn(axis:Vector2D):Number
		{
			return this.dotProduct(axis.normalise())
		}
	}

}