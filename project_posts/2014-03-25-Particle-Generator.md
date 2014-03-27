I've added the beginnings of the class that will create the particles / digital signatures which will represent each participant. At the moment they're generated from a set of data which I'm randomising for proof of concept but the number of geoms, their scales, relative positions and rotational velocities will be set dependent on the participant's heart rate, smoothed voice tone and other factors (calmer colours for lower heart-rates, more vibrant colours and faster rotational velocities for higher heart-rates and voice tones etc) they are pretty crude, and currently just tied into mock data but it wont be hard to experiment with look and feel once I have them tied into the real data source.

####code snippet

```

	public function updateRandomly(e:Event=null):void {
		_mesh.geometry.dispose(); 
		var randomColorInt:int = Math.floor(Math.random() * COLORS.length);
		var color:uint = COLORS[randomColorInt];

		var numGeoms:int = 2 + Math.ceil(Math.random() * 6);
		for (var i:int = 0; i < numGeoms; i++) addRandomMeshToGeometry(i, color);	
		randomiseRotations();
	}
```

I've also exported the app as an interactive [demo](http://seanduffy.pipeten.co.uk/diffeng/particlegen/index.html) simply click on the particle and it will re-create to a new form.

####Composite of several particles
![Particle Generator](../project_images/particles/particleGenerator_1.jpg?raw=true "Particle Generator")




