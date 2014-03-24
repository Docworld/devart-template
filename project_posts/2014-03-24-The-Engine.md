I've added the core of what will be the Difference Engine - a 3D environment which will contain the geometries, materials and lighting. For the final piece each set of 3D geometry will be unique and tied to the participant's data but for this example, and for rapid development, I have just created a standard template mesh and I'm re-using it for each object that gets added to the scene. This template object has a simple grey material for now but the material's colours and textures will ultimately be driven by the user's digital signature recorded at the plus point.

####Template particle
![Template Particle](../project_images/particles/particleTest_single.jpg?raw=true "Template Particle")

My aim here was to test frame-rates and performance, so I cloned and added the above template mesh to the engine one at a time, giving each a set of random parameters (positions in x,y,z space, scale, rotational velocities etc) Starting from position x=y=z=0 and spreading out into the 3D space as more are added. In this test the distribution of particles is fairly random but I plan use [Perlin noise](http://blog.soulwire.co.uk/laboratory/flash/perlin-noise-flow-field) to give the particles a much more organic and fluid distribution. This will come in a later post.

####Screengrabs of Difference Engine taken over time
![Shot 1](../project_images/particles/particleTest_1.jpg?raw=true "Shot 1")
![Shot 2](../project_images/particles/particleTest_2.jpg?raw=true "Shot 2") 
![Shot 3](../project_images/particles/particleTest_3.jpg?raw=true "Shot 3")  

####Results
In the above example I'm generating 8000 sets of geometry, each has its own properties which can be set at creation time and affect the way it behaves over time or in cycles with time. The target frameRate was 60fps but I'm hitting about 30fps - this is because of the graphics card (it's old and cheap) so I expect a modern graphics card would have no problem with 10x the polygons here and at 60fps.

The code above would work just as well with each of the 8000 meshes being unique (instead of from the template). Next I plan to start adding more colour, and will record a video of the engine in action (hopefully on a better graphics card) 



