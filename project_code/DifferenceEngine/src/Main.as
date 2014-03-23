package {
	
	import com.seanjd.devart.DifferenceEngine;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	
	/**
	 * ...
	 * @author SJD
	 */

	//set stage resolution & color using metadata
	[SWF(width=1920, height=1080, backgroundColor=0x000000)]
	public class Main extends Sprite {
		
		private var _differenceEngine:DifferenceEngine;
		
		public function Main():void {
			
			//lock full screen
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			//init the diff engine view & add to stage
			_differenceEngine = new DifferenceEngine();
			addChild(_differenceEngine);
		}
		
	}
	
}