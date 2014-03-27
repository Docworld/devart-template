package com.seanjd.devart {
	
	import com.seanjd.devart.events.SignalHub;
	import fft.FFTMic;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * this will be the mic input but I'm using a 
	 * recorded mp3 for testing purposes
	 * @author SeanJamesDuffy
	 */
	
	public class VoxInput {
		
		private const CHANNEL_LENGTH:int = 256; 
		private const AUDIO_PATH:String = "mp3/IntoTheRainbowVein.mp3";
		
        private var sound:Sound;
		
		private var soundChannel:SoundChannel;
		private var soundTransform:SoundTransform;
		private var bytes:ByteArray = new ByteArray(); 
		
		public function VoxInput() {
		}
		
		public function initMP3():void { 
			sound = new Sound(); 
			var req:URLRequest = new URLRequest(AUDIO_PATH); 
			sound.load(req); 
			soundChannel = sound.play();
			Main.st.addEventListener(Event.ENTER_FRAME, processAudio);
		}
		
		public function initFFTMic():void {
			var fftMic:FFTMic = new FFTMic();
			fftMic.init();
		}
		
		private function processAudio(e:Event):void {
			SoundMixer.computeSpectrum(bytes, true, 0); 
			
			var averageVolThisFrame:Number = 0; 
			for (var i:int = 0; i < CHANNEL_LENGTH; i++) averageVolThisFrame += bytes.readFloat(); 
			
			SignalHub.amplitudeSignal.dispatch(averageVolThisFrame/CHANNEL_LENGTH);
		}
		
	}

}