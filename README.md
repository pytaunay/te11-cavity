Set of files to model a resonant cavity consisting of a cylindrical conductor capped with a thick boron-nitride piece and a conductive iris, operating in the TE11 mode.

By modeling each component of the cavity with lumped elements of a given impedance Z (or admittance Y), a condition for resonance is obtained. 
When losses are introduced, another condition corresponding to matching the cavity to the supporting waveguide is derived. 

The two derived conditions give a relationship between the resonant frequency omega, length of the cavity d, thickness of the boron-nitride t, and radius of the iris, r0.  

---
All files but solve_lossy.m are setting up the impedances, admittances, etc. of the equivalent elements. solve_lossy.m is used to relate two of the four aforementioned parameters together. fsolve is used to obtain parameters satisfying the two derived conditions.  

09/18/2015
Pierre-Yves Taunay
