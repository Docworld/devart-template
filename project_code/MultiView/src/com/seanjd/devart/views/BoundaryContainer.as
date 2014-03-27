package com.seanjd.devart.views {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.tools.helpers.MeshHelper;
	import com.seanjd.devart.DifferenceEngine;
	import com.seanjd.devart.models.Settings;
	import flash.display.BitmapData;
	
	/**
	 * this contains the global bgd geometry and associated materials
	 * @author SJD
	 */
	
	public class BoundaryContainer extends ObjectContainer3D {
		
		private var _sc:MainScene;
		private var _bmd:BitmapData;
		private var _boundary:Mesh;
		
		private var bitmapData:BitmapData;
		private var count:Number = 0;
		
		private var material:MaterialBase; 
		
		public function BoundaryContainer(scene:MainScene) {
			super();
			_sc = scene;
			_boundary = createBoundary();
			//MeshHelper.invertFaces(_boundary);
			addChild(_boundary);
		}
		
		private function createBoundary():Mesh {
			var sphereGeometry:SphereGeometry = new SphereGeometry(Settings.BOUNDARY_RADIUS, 32, 32);
			material = createColorMaterial();// createMaterial();

			//material.lightPicker = _sc.lightPicker;
			return new Mesh(sphereGeometry, material);
		}
		
		private function createColorMaterial():ColorMaterial {
			var mat:ColorMaterial = new ColorMaterial(0xFFFFFF);
			mat.bothSides = true;
			return mat;
		}

		private function createMaterial():TextureMaterial {
			var bitmapData:BitmapData = new BitmapData(512, 512, true, 0xFFFFFFFF);
			//bitmapData.perlinNoise(64, 64, 2, 2, true, false, 3, true);
			var bitmapTexture:BitmapTexture = new BitmapTexture(bitmapData, true);
			var mat:TextureMaterial = new TextureMaterial(bitmapTexture);
			mat.bothSides = true;
			mat.alphaBlending = true;
			return mat;
		}
		
	}

}