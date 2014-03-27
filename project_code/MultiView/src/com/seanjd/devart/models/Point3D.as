package com.seanjd.devart.models {
	import flash.geom.Point;
	
	/**
	 * to store xyz data for 3D point
	 * @author SJD
	 */
	
	public class Point3D extends Point {
		
		public var z:Number;
		
		public function Point3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.z = z;
			super(x, y);
		}
		
	}

}