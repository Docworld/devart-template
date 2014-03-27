package  {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;
	import com.seanjd.devart.views.BoundaryContainer;
	import com.seanjd.devart.views.ParticleContainer;
	
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class MainScene {
		
		public var scene:ObjectContainer3D;
		public var lightPicker:StaticLightPicker;
		
		public function MainScene() {
		}
		
		public function init():void {
			
			scene  = new ObjectContainer3D();
			
			var pointLight:PointLight = addPointLight(1500, 1500, 0, 500, 2500, 30, 0x88e1ff);
			var pointLight2:PointLight = addPointLight(1500, -1300, 0, 500, 2500, 30, 0x88e1ff);
			var pointLight3:PointLight = addPointLight( -1500, 1500, 1500, 500, 2500, 300, 0x88e1ff);
			var pointLight4:PointLight = addPointLight( 0, 0, 1500, 500, 2500, 300, 0x88e1ff);
			var pointLight5:PointLight = addPointLight(0, 0, -1500, 500, 2500, 300, 0x88e1ff);
			var pointLightx:PointLight = addPointLight(0, 0, 0, 0, 3000, 300, 0xFFFFFF);
			lightPicker = new StaticLightPicker([]);// ([pointLight, pointLight2, pointLight3]);
			
			//var boundaryContainer:BoundaryContainer = new BoundaryContainer(this);
			//scene.addChild(boundaryContainer);
			
			var particleContainer:ParticleContainer = new ParticleContainer(this);
			scene.addChild(particleContainer);
			particleContainer.scaleX = particleContainer.scaleY = particleContainer.scaleZ = 3;
		}
		
		private function addPointLight(xPos:Number, yPos:Number, zPos:Number, radius:Number, falloff:Number, specular:Number, color:uint):PointLight {
			//setup a light
			var pointLight:PointLight = new PointLight();
			pointLight.x = xPos;
			pointLight.y = yPos;
			pointLight.z = zPos;
			pointLight.specular = 10;
			pointLight.radius = 50;
			pointLight.fallOff = falloff;
			pointLight.color = color;
			return pointLight;
		}
		
	}

}