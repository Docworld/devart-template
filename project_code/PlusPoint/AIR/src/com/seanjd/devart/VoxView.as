package com.seanjd.devart {
	
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.seanjd.devart.events.SignalHub;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class VoxView extends Sprite {
		
		private var _bgd:DE_Vox_Bgd;
		private var _vox:DE_Vox;
		
		private var _tintWhite:Boolean = false;
		
		public function VoxView() {
			super();
			init();
		}
		
		private function init():void {
			SignalHub.amplitudeSignal.add(updateAmplitude);
			TweenPlugin.activate([TintPlugin]);
			draw();
			//simulate(0.5);
		}

		private function draw():void {
			_bgd = new DE_Vox_Bgd();
			addChild(_bgd);
			_vox = new DE_Vox();
			addChild(_vox);
			_vox.x = 540;
			_vox.y = 960 - 72;
			
			if (Settings.isDesktop) {
				scaleX = scaleY = 0.45;
			}
		}
		
		private function simulate(randomTime:Number):void {
			setTimeout(simulateSignal, (randomTime * 1000));
		}
		
		private function simulateSignal(e:Event=null):void {
			//this will be replaced by a Signal from the system
			var randomTime:Number = Math.random() * 0.3;
			var amp:Number = Math.random() * 0.6;
			update(amp, randomTime);
			simulate(randomTime);
		}
		
		private function update(amp:Number, time:Number):void {
			var scale:Number = 1 + amp;
			TweenLite.to(_vox.outer, time, { scaleX:scale, scaleY:scale, ease:Linear.easeOut } );
			TweenLite.to(_vox.inner, time, {  tint:_tintWhite?0xFFFFFF:0x84F4F6, ease:Linear.easeOut } );
			_tintWhite = !_tintWhite;
		}
		
		private function updateAmplitude(amp:Number):void {
			trace(amp);
			if (amp < 0.015) return;
			var scale:Number = 1 + amp*5;
			_vox.outer.scaleX = _vox.outer.scaleY = scale;
			_vox.inner.alpha = 1 - amp * 5;
			TweenLite.to(_vox.outer, 0.5, { scaleX:1, scaleY:1, ease:Linear.easeOut } );
			TweenLite.to(_vox.inner, 0.5, {  alpha:1, ease:Linear.easeOut } );
		}
		
	}

}