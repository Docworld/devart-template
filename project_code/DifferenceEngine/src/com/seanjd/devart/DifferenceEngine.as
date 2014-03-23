package com.seanjd.devart {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import com.seanjd.devart.models.Settings;
	import com.seanjd.devart.views.BoundaryContainer;
	import com.seanjd.devart.views.ParticleContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	/**
	 * This contains the main components for the difference engine, including the view3d and cameras
	 * It is the class responsible for wiring up the main elements via Signals
	 * @author SJD
	 */
	
	public class DifferenceEngine extends Sprite {
		
		private var _view:View3D;
		private var _coreLight:PointLight;
		
		private var _boundaryContainer:BoundaryContainer;
		private var _mainParticleContainer:ParticleContainer;
		
		static public var lightPicker:StaticLightPicker;
		
		public function DifferenceEngine() {
			super();
			
			initScene();
		}
		
		private function initScene():void {
			
			//setup the view
			_view = new View3D();
			addChild(_view);
			
			//adds stats counter to check frame-rates etc
			if(Settings.DEBUG) addChild(new AwayStats(_view));
			
			//setup the camera
			_view.camera.z = -600;
			_view.camera.y = 500;
			_view.camera.lookAt(new Vector3D());
			
			//add a light in centre of scene
			_coreLight = addPointLight(0, 0, -500, 1500, Settings.CORE_LIGHT_COLOR);
			_view.scene.addChild(_coreLight);
			
			lightPicker = new StaticLightPicker([_coreLight]);
			
			//_boundaryContainer = new BoundaryContainer();
			//_view.scene.addChild(_boundaryContainer);
			
			_mainParticleContainer = new ParticleContainer();
			_view.scene.addChild(_mainParticleContainer);
			
			addEventListener(Event.ENTER_FRAME, render);
		}

		private function addPointLight(xPos:Number, yPos:Number, zPos:Number, falloff:Number, color:uint):PointLight {
			//setup a light
			var pointLight:PointLight = new PointLight();
			pointLight.x = xPos;
			pointLight.y = yPos;
			pointLight.z = zPos;
			pointLight.specular = 0;
			pointLight.radius = 50;
			pointLight.fallOff = falloff;
			pointLight.color = color;
			return pointLight;
		}
		
		//main render loop
		private function render(e:Event):void {
			_mainParticleContainer.rotationY += 0.5;
			_view.render();
		}
		
	}

}