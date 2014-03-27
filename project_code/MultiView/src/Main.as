package {
	
	import be.boulevart.air.utils.ScreenManager;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	[SWF(width=10, height=10, backgroundColor=0x000000, frameRate=60)]
	public class Main extends Sprite {
		
		static public const SCREEN_WIDTH:uint = 1680;
		static public const SCREEN_HEIGHT:uint = 1050;
		
		private var _scene:MainScene;
		
		public function Main():void {

			createViewModel();
			createMultipleViewports();
		}
		
		private function createViewModel():void {
			//this is a global 3D scene which each of the viewports have access to and can render
			_scene = new MainScene();
			_scene.init();
		}
		
		private function createMultipleViewports():void {
			createAIRViewport(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, ScreenManager.TOP_LEFT_CORNER, 0);
			createAIRViewport(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, ScreenManager.TOP_RIGHT_CORNER, 1);
			createAIRViewport(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, ScreenManager.BOTTOM_LEFT_CORNER, 2);
			createAIRViewport(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, ScreenManager.BOTTOM_RIGHT_CORNER, 3);
		}
		
		private function createAIRViewport(width:Number, height:Number, corner:String, ind:int):void {
			
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.renderMode = "direct";
			options.systemChrome = NativeWindowSystemChrome.NONE;

			var nw:NativeWindow = new NativeWindow(options);
			nw.bounds = new Rectangle(0, 0, width, height);
			nw.stage.scaleMode = StageScaleMode.NO_SCALE;
			nw.stage.align = StageAlign.TOP_LEFT;

			var engineViewport:EngineViewport = new EngineViewport(_scene);
			nw.stage.addChild(engineViewport);
			ScreenManager.openWindowInCorner(nw, 2, corner);
			engineViewport.init(ind);
		}
		
	}
	
}