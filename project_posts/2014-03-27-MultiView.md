I'm now rendering the 3D scene from 4 different viewpoints and displaying each one through a separate app window. This means that our final live scene can be shot from 4 virtual cameras and the output of these will be fed back through 4 projectors to re-create the scene. Any kind of view transformations can be applied to fit these to the final display (be it a wraparound cylinder or dome) but for this example (just a technical proof of concept) I'm putting 4 cameras facing in 4 opposite corners and rendering the center of the 3D scene (world co-ordinates 0,0,0). 

####code snippet

```

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
	
	public function EngineViewport(scene:MainScene) {
			super();
			_scene = scene;
		}
		
		public function init(ind:int):void {

			if (ind == 0) _view = new View3D();
			else _view = new View3D(ViewManager.views[0].scene);

			ViewManager.views[ind] = _view;

	...


```

The rest of the code has been checked in (a test app so in a new directory called 'MultiView') 

Here are some screenshots to display the particle system growing - I'm getting decent frame rates whilst rendering but not whilst screencasting to video too, so I'm just using stills for this post.

These are combined into a single screen (1680x1050 pixels) but in the final version each output will be full HD (i.e. 1920x1080x4)

####grab 1

![Shot1](../project_images/particles/MultiViewParticles_1.jpg?raw=true "Shot1")

####grab 2

![Shot2](../project_images/particles/MultiViewParticles_2.jpg?raw=true "Shot2")

####grab 3

![Shot3](../project_images/particles/MultiViewParticles_3.jpg?raw=true "Shot3")
