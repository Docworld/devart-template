package fft {
	import com.seanjd.devart.events.SignalHub;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.utils.Timer;
	
	
	/**
	 * @author SeanJamesDuffy
	 */
	
	public class FFTMic {
		
		private const SAMPLE_RATE:Number = 22050;   // Actual microphone sample rate (Hz)
        private const LOGN:uint = 11;               // Log2 FFT length
        private const N:uint = 1 << LOGN;         // FFT Length
        private const BUF_LEN:uint = N;             // Length of buffer for mic audio
        private const UPDATE_PERIOD:int = 50;       // Period of spectrum updates (ms)
 
        private var m_fft:FFT2;                     // FFT object
 
        private var m_tempRe:Vector.<Number>;     // Temporary buffer - real part
        private var m_tempIm:Vector.<Number>;     // Temporary buffer - imaginary part
        private var m_mag:Vector.<Number>;            // Magnitudes (at each of the frequencies below)
        private var m_freq:Vector.<Number>;           // Frequencies (for each of the magnitudes above)
        private var m_win:Vector.<Number>;            // Analysis window (Hanning)
 
        private var m_mic:Microphone;               // Microphone object
        private var m_writePos:uint = 0;            // Position to write new audio from mic
        private var m_buf:Vector.<Number> = null; // Buffer for mic audio
 
        private var m_tickTextAdded:Boolean = false;
 
        private var m_timer:Timer;                  // Timer for updating spectrum
		
		public function FFTMic() {
		}
		
		public function init():void {
			var i:uint;
 
            // Set up the FFT
            m_fft = new FFT2();
            m_fft.init(LOGN);
            m_tempRe = new Vector.<Number>(N);
            m_tempIm = new Vector.<Number>(N);
            m_mag = new Vector.<Number>(N/2);
            //m_smoothMag = new Vector.<Number>(N/2);
 
            // Vector with frequencies for each bin number. Used
            // in the graphing code (not in the analysis itself).
            m_freq = new Vector.<Number>(N/2);
            for ( i = 0; i < N/2; i++ )
                m_freq[i] = i*SAMPLE_RATE/N;
 
            // Hanning analysis window
            m_win = new Vector.<Number>(N);
            for ( i = 0; i < N; i++ )
                m_win[i] = (4.0/N) * 0.5*(1-Math.cos(2*Math.PI*i/N));
 
            // Create a buffer for the input audio
            m_buf = new Vector.<Number>(BUF_LEN);
            for ( i = 0; i < BUF_LEN; i++ )
                m_buf[i] = 0.0;
 
            // Set up microphone input
            m_mic = Microphone.getMicrophone();
            m_mic.rate = SAMPLE_RATE / 1000;
			m_mic.gain = 100;
            m_mic.setSilenceLevel(0.0);         // Have the mic run non-stop, regardless of the input level
            m_mic.addEventListener( SampleDataEvent.SAMPLE_DATA, onMicSampleData );
 
            // Set up a timer to do periodic updates of the spectrum
            m_timer = new Timer(UPDATE_PERIOD);
            m_timer.addEventListener(TimerEvent.TIMER, updateSpectrum);
            m_timer.start();
		}
		
		/**
         * Called whether new microphone input data is available. See this call
         * above:
         *    m_mic.addEventListener( SampleDataEvent.SAMPLE_DATA, onMicSampleData );
         */
        private function onMicSampleData( event:SampleDataEvent ):void
        {
            // Get number of available input samples
            var len:uint = event.data.length/4;
 
            // Read the input data and stuff it into
            // the circular buffer
            for ( var i:uint = 0; i < len; i++ )
            {
                m_buf[m_writePos] = event.data.readFloat();
                m_writePos = (m_writePos+1)%BUF_LEN;
            }
        }
 
        /**
         * Called at regular intervals to update the spectrum
         */
        private function updateSpectrum( event:Event ):void
        {
            // Copy data from circular microphone audio
            // buffer into temporary buffer for FFT, while
            // applying Hanning window.
            var i:int;
            var pos:uint = m_writePos;
            for ( i = 0; i < N; i++ )
            {
                m_tempRe[i] = m_win[i]*m_buf[pos];
                pos = (pos+1)%BUF_LEN;
            }
 
            // Zero out the imaginary component
            for ( i = 0; i < N; i++ )
                m_tempIm[i] = 0.0;
 
            // Do FFT and get magnitude spectrum
            m_fft.run( m_tempRe, m_tempIm );
            for ( i = 0; i < N/2; i++ )
            {
                var re:Number = m_tempRe[i];
                var im:Number = m_tempIm[i];
                m_mag[i] = Math.sqrt(re*re + im*im);
            }

			var averageMag:Number = 0;
			for (var n:uint = 0; n < m_mag.length; n++) {
				averageMag += m_mag[n];
			}
			averageMag /= m_mag.length;
			
			var normalisedSignal:Number = averageMag * 10;
			SignalHub.amplitudeSignal.dispatch(normalisedSignal);
        }
		
	}

}