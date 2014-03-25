package com.seanjd.devart.views {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.CompactSubGeometry;
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.SphereGeometry;
	import away3d.tools.commands.Merge;
	import com.seanjd.devart.DifferenceEngine;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class ParticleGenerator extends ObjectContainer3D {
		
		private const COLORS:Vector.<uint> = Vector.<uint>([0xccf057, 0xa2bcb5, 0x688afc, 0x643e88, 0xd49992, 0x4ec978, 0xee9c92, 0xe58d3, 0x8b8ef4, 0xee5540, 0x5d681, 0x72af53, 0xe50000, 0xcc0000, 0xb20000, 0x990000, 0x7f0000, 0xff1919, 0xff3232, 0xff9999]);
		
		private var _merge:Merge;
		private var _mesh:Mesh;
		private var _geometry:Geometry;
		private var _material:MaterialBase;
		
		private var _rx:Number = 0;
		private var _ry:Number = 0;
		private var _rz:Number = 0;
		
		public function ParticleGenerator() {
			super();
			
			_merge = new Merge(true, true);
			_mesh = new Mesh(new Geometry());
			addChild(_mesh);
			
			//Main.ref.addEventListener(Event.ENTER_FRAME, updateRotations);
			
			updateRandomly();
		}
		
		private function updateRotations(e:Event):void {
			rotationX += _rx;
			rotationY += _ry;
			rotationZ += _rz;
		}
		
		public function updateRandomly(e:Event=null):void {
			//updateMaterial();
			//updateGeometry();
			_mesh.geometry.dispose();
			
			var randomColorInt:int = Math.floor(Math.random() * COLORS.length);
			var color:uint = COLORS[randomColorInt];

			var numGeoms:int = 2 + Math.ceil(Math.random() * 6);
			for (var i:int = 0; i < numGeoms; i++) addRandomMeshToGeometry(i, color);	
			addNoise();
			
			randomiseRotations();
		}
		
		private function randomiseRotations():void {
			_rx = Math.sin(Math.random());
			_ry = Math.sin(Math.random())*4;
			_rz = Math.sin(Math.random());
		}
		
		private function addNoise():void {
			for each(var subGeom:CompactSubGeometry in _mesh.geometry.subGeometries) {
				for (var i:uint = 0; i < subGeom.vertexData.length; i++) {
					subGeom.vertexData[i] += Math.sin(Math.random())/4;
				}
			}
		}

		private function updateMaterial():void {
			_material = new ColorMaterial(0xFF0000, Math.random());
			_material.lightPicker = DifferenceEngine.lightPicker;
			_mesh.material = _material;
		}
		
		private function updateGeometry():void {
		}
		
		private function addRandomMeshToGeometry(index:int, color:uint):void {
			var positionMultiplier:Number = 12;
			var segs:int = 4 + Math.ceil(Math.random() * 12);
			var geometry:Geometry = new SphereGeometry((10-(index*2))+Math.random() * 4, segs, segs);
			var mesh:Mesh = new Mesh(geometry, getRandomMaterial(color));
			mesh.x = Math.sin(Math.random()) * index * positionMultiplier;
			mesh.y = Math.sin(Math.random()) * index * positionMultiplier;
			mesh.z = Math.sin(Math.random()) * index * positionMultiplier;
			_merge.apply(_mesh, mesh);
		}
		
		private function getRandomMaterial(color:uint):MaterialBase {
			var material:MaterialBase = new ColorMaterial(color, 0.6+Math.random()*0.4);
			material.lightPicker = DifferenceEngine.lightPicker;
			return material;
		}
	}

}