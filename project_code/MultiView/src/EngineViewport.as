package  {
	
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class EngineViewport extends Sprite {
		
		private const CAMERA_DISTANCE:uint = 1500;
		
		private var _view:View3D;
		private var _scene:MainScene;
		
		public function EngineViewport(scene:MainScene) {
			super();
			_scene = scene;
		}
		
		public function init(ind:int):void {

			if (ind == 0) _view = new View3D();
			else _view = new View3D(ViewManager.views[0].scene);

			ViewManager.views[ind] = _view;

			addChild(_view);
			_view.scene.addChild(_scene.scene);
			addChild(new AwayStats(_view));

			locateCamera(ind);
			
			_view.backgroundColor = 0xFFFFFF;
			//_view.background = new BitmapTexture(createBgd(0xFFFFFF));
			
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function locateCamera(ind:int):void {
			switch(ind) {
				case 0:
				_view.camera.x = 0;
				_view.camera.y = CAMERA_DISTANCE;
				_view.camera.z = -CAMERA_DISTANCE;
				break;
				case 1:
				_view.camera.x = CAMERA_DISTANCE;
				_view.camera.z = 0;
				break;
				case 2:
				_view.camera.x = 0;
				_view.camera.z = CAMERA_DISTANCE;
				break;
				case 3:
				_view.camera.x = -CAMERA_DISTANCE;
				_view.camera.z = 0;
				break;
			}
			//set all to look at center (0,0,0)
			_view.camera.lookAt(new Vector3D());
		}

		private function createBgd(color:uint):BitmapData {
			var bitmapData:BitmapData = new BitmapData(1024, 1024);
			bitmapData.floodFill(1, 1, color);
			return bitmapData;
		}
		
		private function render(e:Event):void {
			_scene.scene.rotationX += 0.5;
			_scene.scene.rotationZ += 0.1;
			_view.render();
		}
		
	}

}