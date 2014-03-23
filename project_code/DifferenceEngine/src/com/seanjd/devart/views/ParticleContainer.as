package com.seanjd.devart.views {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Geometry;
	import away3d.core.base.Object3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.tools.commands.Merge;
	import com.seanjd.devart.DifferenceEngine;
	import com.seanjd.devart.models.SignatureData;
	
	/**
	 * ...
	 * @author SJD
	 */
	
	public class ParticleContainer extends ObjectContainer3D {
		
		private var _particleMesh:Mesh = new Mesh(new Geometry());
		private var _merge:Merge = new Merge(false, true);
		private var _particles:Vector.<SignatureParticle> = new Vector.<SignatureParticle>;
		
		static public var sphere:SphereGeometry = new SphereGeometry(6);
		static public var material:ColorMaterial = new ColorMaterial(0xFFFFFF);
		
		private var _meshes:Vector.<Mesh> = new Vector.<Mesh>;
		
		private var _signatureParticle:SignatureParticle = new SignatureParticle(new SignatureData());
		
		public function ParticleContainer() {
			super();
			material.lightPicker = DifferenceEngine.lightPicker;
			for (var i:uint = 0; i < 3; i++) createContainer();
		}
		
		private function createContainer():void {
			var particleMesh:Mesh = new Mesh(new Geometry(), material);
			addChild(particleMesh);
			for (var i:uint = 0; i < 800; i++) createParticle(particleMesh);
			_merge.applyToMeshes(particleMesh, _meshes);
		}
		
		private function createParticle(container:Mesh):void {
			var signatureParticle:SignatureParticle = new SignatureParticle(new SignatureData());
			//_particles.push(signatureParticle);
			
			//var signatureParticle:Object3D = _signatureParticle.clone();
			
			signatureParticle.x = Math.random() * 500;
			if (Math.random() < 0.5) signatureParticle.x = -signatureParticle.x;
			signatureParticle.z = Math.random() * 500;
			if (Math.random() < 0.5) signatureParticle.z = -signatureParticle.z;

			var distFromCentre:Number = Math.sqrt((signatureParticle.x * signatureParticle.x) + (signatureParticle.z * signatureParticle.z));
			var multiplier = 500 - distFromCentre;
			signatureParticle.y = Math.random() * multiplier / 5;
			if (Math.random() < 0.5) signatureParticle.y = -signatureParticle.y;
			
			signatureParticle.rotationX = Math.random() * 360;
			signatureParticle.rotationY = Math.random() * 360;
			signatureParticle.rotationZ = Math.random() * 360;
			
				
			//_merge.apply(container, signatureParticle);
			//addChild(signatureParticle);
			_meshes.push(signatureParticle);
		}
		
	}

}