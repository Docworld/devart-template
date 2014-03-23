package com.seanjd.devart.views {
	
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.SphereGeometry;
	import away3d.tools.commands.Merge;
	import away3d.tools.helpers.MeshHelper;
	import com.seanjd.devart.models.SignatureData;
	
	/**
	 * ...
	 * @author SJD
	 */
	public class SignatureParticle extends Mesh {
		
		private var _merge:Merge = new Merge(false, true);
		private var _geom:Geometry;
		private var _mat:MaterialBase;
		
		public function SignatureParticle(data:SignatureData) {
			
			_geom = new Geometry();
			_mat = ParticleContainer.material;
	
			super(_geom, _mat);
			
			for (var i:uint = 0; i < data.geoms.length; i++){
				var mesh:Mesh = new Mesh(data.geoms[i], _mat);
				
				/*mesh.x = i * Math.random() * 5;
				if (Math.random() < 0.5) mesh.x = -mesh.x;
				mesh.y = i * Math.random() * 5;
				if (Math.random() < 0.5) mesh.y = -mesh.y;
				mesh.z = i * Math.random() * 5;
				if (Math.random() < 0.5) mesh.z = -mesh.z;*/
				
				mesh.x = data.positions[i].x;
				mesh.y = data.positions[i].y;
				mesh.z = data.positions[i].z;
				
				_merge.apply(this, mesh);
			}
		}
		
	}

}