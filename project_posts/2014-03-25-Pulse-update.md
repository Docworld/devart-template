I've had some advice from Pedro Chambino (the developer of the Pulse library) on how to make the extraction algorithm more stable. This is at the expense of accuracy but after a bit of playing and tweaking I think I've found a happy medium. I've updated Pulse.cpp with some new properties which make the app less likely to drop out (this will be important for visitors to get a strong reading over the 10 seconds their heart-rate is being recorded)



