package com.seanjd.devart {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import com.seanjd.devart.models.Settings;
	import com.seanjd.devart.models.SignatureData;
	import com.seanjd.devart.views.BoundaryContainer;
	import com.seanjd.devart.views.ParticleContainer;
	import com.seanjd.devart.views.ParticleGenerator;
	import com.seanjd.devart.views.SignatureParticle;
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
		//lights
		private var _coreLight:PointLight;
		private var _directionalLight:DirectionalLight;
		
		private var _particleGenerator:ParticleGenerator;
		private var _boundaryContainer:BoundaryContainer;
		private var _mainParticleContainer:ParticleContainer;
		private var camZ:Number = 0;;
		
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
			_view.camera.z = -200;
			_view.camera.y = 5;
			_view.camera.lookAt(new Vector3D());
			
			//add a light in centre of scene
			_coreLight = addPointLight(0, 0, -1000, 1200, Settings.CORE_LIGHT_COLOR);
			_view.scene.addChild(_coreLight);
			var pLight2 = addPointLight(100, 100, 100, 130, Settings.CORE_LIGHT_COLOR);
			_view.scene.addChild(pLight2);
			
			_directionalLight = addDirectionalLight();
			_view.scene.addChild(_directionalLight);
			
			lightPicker = new StaticLightPicker([_coreLight, _directionalLight]);
			
			//_boundaryContainer = new BoundaryContainer();
			//_view.scene.addChild(_boundaryContainer);
			
			//_mainParticleContainer = new ParticleContainer();
			//_view.scene.addChild(_mainParticleContainer);
			
			_particleGenerator = new ParticleGenerator();
			_view.scene.addChild(_particleGenerator);
			
			addEventListener(Event.ENTER_FRAME, render);
			addEventListener(MouseEvent.CLICK, _particleGenerator.updateRandomly);
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
		private function addDirectionalLight():DirectionalLight {
			var dLight:DirectionalLight = new DirectionalLight(1, 0, -0.5);
			dLight.color = 0xFFFFFF;
			return dLight;
		}
		
		//main render loop
		private function render(e:Event):void {
			trace("render");
			//_mainParticleContainer.rotationX -= 0.05
			//_mainParticleContainer.rotationY += 0.5;
			_view.render();
		}
		
	}

}