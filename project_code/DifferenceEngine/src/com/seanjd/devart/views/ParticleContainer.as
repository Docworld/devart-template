package com.seanjd.devart.views {
	
	import away3d.animators.data.ParticleProperties;
	import away3d.animators.data.ParticlePropertiesMode;
	import away3d.animators.nodes.ParticlePositionNode;
	import away3d.animators.nodes.ParticleRotationalVelocityNode;
	import away3d.animators.nodes.ParticleScaleNode;
	import away3d.animators.ParticleAnimationSet;
	import away3d.animators.ParticleAnimator;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Geometry;
	import away3d.core.base.ParticleGeometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.tools.helpers.ParticleGeometryHelper;
	import com.seanjd.devart.DifferenceEngine;
	import com.seanjd.devart.models.SignatureData;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author SJD
	 */
	
	public class ParticleContainer extends ObjectContainer3D {
		
		static public const PARTICLE_COUNT:uint = 8000;
		
		private var particleMesh:Mesh;
		static public var material:MaterialBase;
		private var geometrySet:Vector.<Geometry> = new Vector.<Geometry>;
		private var particleGeometry:ParticleGeometry;
		private var animationSet:ParticleAnimationSet;
		private var animator:ParticleAnimator;
		
		public function ParticleContainer() {
			super();
			
			material = new ColorMaterial(0xFFFFFF);
			material.lightPicker = DifferenceEngine.lightPicker;;
			
			//var p:SignatureParticle = new SignatureParticle(new SignatureData());
			//addChild(p);
			//return;
			
			var sig:SignatureParticle = new SignatureParticle(new SignatureData());
			var sigGeom:Geometry = sig.geometry;
			
			for (var i:int = 0; i < PARTICLE_COUNT; i++){
				geometrySet.push(sigGeom);
			}
			
			particleGeometry = ParticleGeometryHelper.generateGeometry(geometrySet);
			animationSet = new ParticleAnimationSet(true, true, true);
			
			animationSet.initParticleFunc = initParticleParam;
			animationSet.addAnimation(new ParticlePositionNode(ParticlePropertiesMode.LOCAL_STATIC));
			animationSet.addAnimation(new ParticleRotationalVelocityNode(ParticlePropertiesMode.LOCAL_STATIC));
			animationSet.addAnimation(new ParticleScaleNode(ParticlePropertiesMode.LOCAL_STATIC,false, false));
			
			particleMesh = new Mesh(particleGeometry, material);
			
			animator = new ParticleAnimator(animationSet);
			particleMesh.animator = animator;
			animator.start();
			
			addChild(particleMesh);
		}
		
		private function initParticleParam(prop:ParticleProperties):void{
			prop.startTime = prop.index * 0.005;
			prop.duration = 10000;
			prop.delay = 5;
			
			//calculate the original position of every particle.
			var percent:Number = prop.index / prop.total;
			var r:Number = percent * 1000;
			var x:Number = r * Math.cos(percent * Math.PI * 2 * 20);
			var y:Number = 100 - (r * Math.cos(percent * Math.PI * 2 * 20));
			var z:Number = r * Math.sin(percent * Math.PI * 2 * 20);

			x = Math.sin(Math.random() * Math.PI * 2) * prop.index/5;
			z = Math.sin(Math.random() * Math.PI * 2) * prop.index / 5;
			
			y = 1/(x/1000) * 10;
			
			var scale:Number = Math.random()*1.5;
			prop[ParticlePositionNode.POSITION_VECTOR3D] = new Vector3D(x, y, z);
			prop[ParticleRotationalVelocityNode.ROTATIONALVELOCITY_VECTOR3D] = new Vector3D(Math.random(), Math.random(), Math.random(), 10);// (Math.random() * 0.001, Math.random() * 0.001, Math.random() * 0.001, Math.random() * 0.001);
			prop[ParticleScaleNode.SCALE_VECTOR3D] = new Vector3D(scale, scale, scale, 1);
		}
		
	}

}