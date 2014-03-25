package {
	
	import com.seanjd.devart.DifferenceEngine;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author SJD
	 */

	//set stage resolution & color using metadata
	[SWF(width=840, height=525, backgroundColor=0x000000, frameRate=60)]
	public class Main extends Sprite {
		
		private var _differenceEngine:DifferenceEngine;
		
		static public var ref:Main;
		
		public function Main():void {
			
			//lock full screen
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			ref = this;
			
			//init the diff engine view & add to stage
			_differenceEngine = new DifferenceEngine();
			addChild(_differenceEngine);
		}

	}
	
}