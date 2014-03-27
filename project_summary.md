# Difference Engine


## Authors
- Sean Duffy - [https://github.com/SeanJD](https://github.com/SeanJD)  
- Matthew Clugston

## Description
This piece aims to inspire visitors to focus on the positive things they contribute to society. It is meant as an antidote to the negative media spin on how people are a drain on resources, and increasingly portrayed as parasites that are over-populating the planet. 

To interact with the exhibit the participant will be asked to think of a personal act which has had a positive contribution to the people around them, this may be related to their job, looking after an ill relative, or just a simple act of kindness towards someone else.

They will be prompted to think about and record this act at one of the several ‘plus points’ in the exhibition space. Along with voicing this positive personal message a short recording of the participant’s heart-beat will be taken via a contactless recording technique. The data from the voice recording will be combined with the heart recording to form a unique digital signature for that participant. 

The visitor’s ‘unique digital signature’ will then be presented to them at the plus point in the form of an organic 3D particle model which has a pulse related to their own bio-rhythm. A sound-cone above the plus point will also allow the visitor to hear this digital signature by modulating their data onto an audio signal. After briefly viewing this digital form the participant will be able to add it to the collective form that makes up the installations centre-piece.

The core of the installation will be a mesmerising 3D graphics piece projected onto a wraparound screen using multiple projectors. This will start off as an empty void but will come to life as soon as the first participant contributes their personal recording. When adding their 3D particle signature to the collective it has a combined effect on the whole scene. The combined data will be put through an algorithm which will drive several properties of the scene and its particle system including the geometry, velocity, colour, lighting and textures. This will be done through a set of vertex and fragment shaders, along with controlling camera and light properties within the scene. As well as driving inputs to the graphics system this collective data will be modulated onto an ambient audio signal played back in the space via a surround-sound. 

Over time as more people contribute their [different] messages to the [engine] the combined form will evolve from nothingness to a beautiful and mesmerising 3D particle system, shot from several virtual viewpoints and stitched together to form a wraparound environment. As the piece evolves we will begin to see mood changes from the collective whole which will have an impact on the sound and visuals which in turn will also affect the next set of contributors. This will signify how the small and seemingly inconsequent positive actions we perform add up to a combined effect which is greater than the sum of its parts.


##Code snippets

####init

```

	var differenceEngine:DifferenceEngine = new DifferenceEngine();
	differenceEngine.init();
	SignalHub.addSignature.add(updateEngine);

	private function updateEngine(signatureData:SignatureData):void{
		differenceEngine.inject(signatureData);
	}

```

####signature data structure
```

	public class SignatureData{
		private var _id:uint;//user is anonymous, simply for internal id
		private var _eyeCol:uint;//average hex value
		private var _bpm:Number;//average heart rate 
		private var _heartData:ByteArray;//stores entire graph as BA
		private var _message:ByteArray;//stores audio msg as BA
		
		private var _positions:Vector.<Point3D> = new Vector.<Point3D>;
		private var _geoms:Vector.<Geometry> = new Vector.<Geometry>;
		private var _mats:Vector.<MaterialBase> = new Vector.<MaterialBase>;
		
		public function SignatureData(id:uint,eyeCol:uint,bpm:Number,heartData:ByteArray,message:ByteArray) {
			//init
		}

```

##Technologies

####Plus Points (input points)
- Android OS device (probably a Nexus5 or Nexus7)
- Android SDK/Java
- Pulse library (Eulerian Video Magnification by Pedro Chambino, see libs)
- C++, JNI
- AIR SDK + AIR ANE

####Core App
- AIR SDK
- AS3/HaXe
- Away3D
- Stage3D
- AGAL
- JSON 

####Hardware
- Multiple Nexus 5 handsets
- 2 Windows Desktop Machines with Quad output graphics cards (2nd as backup machine)
- 4 short-throw HD projectors
- Surround sound system + mixing desk 
- Screen & projection rigging, Audio rigging, device stands for Plus Points




## Links to External Libraries

- [Pulse](https://github.com/pchambino/pulse)
- [Away3D](https://github.com/away3d/)
- [Evo Spicy](https://github.com/simppafi/evoSpicyParticleEngine)
- [Signals (Robert Penner's implementation)](https://github.com/robertpenner/as3-signals)
- [FFT](http://gerrybeauregard.wordpress.com/2010/08/03/an-even-faster-as3-fft/)



## Images & Videos

####Top down view of Difference Engine
![Top down view of Difference Engine](project_images/DE_BirdsEye.jpg?raw=true "Top down view of Difference Engine")

####Plus Point App - wireframes 1
![App wireframes 1](project_images/PlusPointApp_1.jpg?raw=true "App wireframes 1")

####Plus Point App - wireframes 2
![App wireframes 2](project_images/PlusPointApp_2.jpg?raw=true "App wireframes 2")


##Credits

- Thanks to Abi Tura for the concept inspiration
- Thanks to Pedro Chambino for the Pulse lib and advice on integration
- Thanks to Devon McFarlane for teaching me some of his AE skills 
