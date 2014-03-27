package com.seanjd.perlin {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author SJD
	 */
	
	[SWF(width=1024, height=1024, backgroundColor=0xFFFFFF)]
	public class PerlinTests extends Sprite {
		
		private var _bitmapData:BitmapData;
		private var _count:Number = 0;
		
		public function PerlinTests() {
			super();
			
			addPerlinNoise();
			addEventListener(Event.ENTER_FRAME, updatePerlinNoise);
			addChild(new Stats());
		}
		
		private function addPerlinNoise():void {
			_bitmapData = new BitmapData(512, 512, true, 0xFF000000);
			_bitmapData.perlinNoise(64, 64, 4, 1.2, false, true, 7, true);
			addChild(new Bitmap(_bitmapData));
			
		}
		
		private function updatePerlinNoise(e:Event):void {
			var xOffset:Number = Math.sin(_count)*10;
			_count += 0.1;
			_bitmapData.perlinNoise(64, 64, 2, 1, false, true, 7, true, [new Point(xOffset, 0), new Point(xOffset/3, 0)]);
		}
		
	}

}