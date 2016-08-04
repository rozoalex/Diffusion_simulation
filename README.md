# Diffusion_simulation
This is a Matlab simulation of the smog particles concentration.
The smog concentration is modeled with the diffusion equation in one dimension: dC(x,t)/dt=D*(d/dx)*dC(x,t)/dx 
where D is a constant, x is the distance on x-axis, t is the time and the C is the concentration of particles. 
C is a function of x and t.  
All simulations are done in an unitless way. 

dd1 plots the concentration on x direction. It plots the concentration at four different times. 

finddiffusion is a 3d animation of the simulation. It simulates the process of diffusion with 2 dimension, if you starts with high concentration region in the center. The area is modeled as a sqaure. The z axis represents the concentration of particles. 

findfiffusion_reac uses a different model of diffusion equation. It assumes that there is another factor that increases as concentration decreases and the concentration will increase faster if the factor increases. The simulation is done in 1 dimension. the red curve represents the concentration and the black curve represents the other factor. The local maximum of each time is plotted on the right side. 

findfiffusion_sin_model has another factor whose concentration is a sin function of time. 


