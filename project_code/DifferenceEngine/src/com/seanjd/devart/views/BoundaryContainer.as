package com.seanjd.devart.views {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.tools.helpers.MeshHelper;
	import com.seanjd.devart.DifferenceEngine;
	import com.seanjd.devart.models.Settings;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	/**
	 * this contains the global bgd geometry and associated materials
	 * @author SJD
	 */
	
	public class BoundaryContainer extends ObjectContainer3D {
		
		private var _bmd:BitmapData;
		private var _boundary:Mesh;
		
		private var bitmapData:BitmapData;
		private var count:Number = 0;
		
		private var material:TextureMaterial; 
		
		public function BoundaryContainer() {
			super();
			_boundary = createBoundary();
			MeshHelper.invertFaces(_boundary);
			addChild(_boundary);
			
			//setTimeout(updatePerlin, 1000);
		}
		
		private function updatePerlin(e:Event=null):void {
			BitmapTexture(material.texture).bitmapData.perlinNoise(64, 64, 2, Math.floor(Math.random()*10), true, false, 3, true, [new Point(count, 0), new Point(count / 3, 0)]);
			//bitmapData.perlinNoise(64, 64, 2, 2, true, false, 3, true, [new Point(count, 0), new Point(count / 3, 0)]);
			count += 1.1;
		}
		
		private function createBoundary():Mesh {
			var sphereGeometry:SphereGeometry = new SphereGeometry(Settings.BOUNDARY_RADIUS, 32, 32);
			//var material:ColorMaterial = new ColorMaterial(0xFFFFFF, 1);
			material = createMaterial();

			material.lightPicker = DifferenceEngine.lightPicker;
			return new Mesh(sphereGeometry, material);
		}

		private function createMaterial():TextureMaterial {

			bitmapData = new BitmapData(512, 512, true, 0xFFFFFFFF);
			//bitmapData.perlinNoise(64, 64, 2, 2, true, false, 3, true);
			var bitmapTexture:BitmapTexture = new BitmapTexture(bitmapData, true);
			var mat:TextureMaterial = new TextureMaterial(bitmapTexture);
			mat.bothSides = true;
			mat.alphaBlending = true;
			return mat;
		}
		
	}

}