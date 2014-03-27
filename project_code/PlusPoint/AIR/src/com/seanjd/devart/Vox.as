package com.seanjd.devart {
	
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class Vox {
		
		private var _voxView:VoxView;
		private var _voxInput:VoxInput;
		
		public function Vox() {
		}
		
		public function init():void {
			_voxView = new VoxView();
			Main.st.addChild(_voxView);
			
			_voxInput = new VoxInput();
			_voxInput.initMP3();
			//_voxInput.initFFTMic();
		}
		
	}

}