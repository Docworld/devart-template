package {
	
	import com.seanjd.devart.Vox;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author SeanJamesDuffy
	 */
	
	[SWF(width=1920, height=1080, backgroundColor=0x000000, frameRate=60)]
	public class Main extends Sprite {
		
		static public var st:Stage;
		
		//this listens to input from the microphonbe and updates the display accordingly
		private var _vox:Vox;
		
		public function Main():void {
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			st = stage;
			
			Settings.isDesktop = Capabilities.os.indexOf("Windows") != -1;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_vox = new Vox();
			_vox.init();
		}
		
		private function deactivate(e:Event):void {
			// make sure the app behaves well (or exits) when in background
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}