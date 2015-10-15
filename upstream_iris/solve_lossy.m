clear all

% Calculate 2 parameters of a cavity with a thick piece of BN and an iris
% Overall parameters:
% - om, resonant frequency (rad/s)
% - a, radius of the cavity (m)
% - d, length of the cavity (m)
% - t, thickness of BN (m)
% - r, radius of iris (m)

% Load our TE11 cavity model
lossy_cavity_with_BN

% Set up some fixed values
a = 1.068/2*2.54e-2;
ap = 1.284/2*2.54e-2; 

fr = 7.95e9;
om = 2*pi*fr;
d = 8.04e-2; % 8.04 cm
t = 0.3917*2.54e-2; % Half a wavelength at 8 GHz in BN
dg= 0.6439*2.54e-2;
T = 300; % Room temperature (K)

% Set up and solve functional 
% Unknowns are  L (length before BN) and r0 (iris size) -- initial value is 5 in. and 9mm
f0 = [5*2.54e-2,0.009];

options = optimoptions('fsolve','Display','iter','TolFun',1e-16,'TolX',1e-16);

% System recast in a slightly nicer way
res = fsolve(@(X)[Zb_ll(om,a,ap,d,dg,t,X(1)) + 1i*Xi(om,a,X(2)),Zb(om,a,ap,d,dg,t,X(1),T) + 1i*Xi(om,a,X(2))*(1-Zb(om,a,ap,d,dg,t,X(1),T) )],f0,options)	

%%% At T = 1000C
% Set up some fixed values
a = 1.08276/2*2.54e-2;
ap = 1.289499/2*2.54e-2; 

fr = 7.95e9;
om = 2*pi*fr;
d = 8.100283e-2; % 8.04 cm
dg = 0.5042*2.54e-2; %  
t = 0.406533*2.54e-2; % Half a wavelength at 8 GHz in BN
T = 1273; % 1000 degC

% Set up and solve functional 
% Unknowns are  L (length before BN) and r0 (iris size) -- initial value is 5 in. and 9mm
f0 = [5*2.54e-2,0.009];

options = optimoptions('fsolve','Display','iter','TolFun',1e-16,'TolX',1e-16);

% System recast in a slightly nicer way
res_1000 = fsolve(@(X)[Zb_ll(om,a,ap,d,dg,t,X(1)) + 1i*Xi(om,a,X(2)),Zb(om,a,ap,d,dg,t,X(1),T) + 1i*Xi(om,a,X(2))*(1-Zb(om,a,ap,d,dg,t,X(1),T) )],f0,	options)	
%%% What happens to resonant frequency with dimensions from T = 1000C, at T = 300K
a = 1.068/2*2.54e-2;
ap = 1.284/2*2.54e-2; 

d = 8.04e-2; % 8.04 cm
dg = 0.5004*2.54e-2;
r0 = 0.4857*2.54e-2/2;
t = 0.405*2.54e-2; % Half a wavelength at 8 GHz in BN
T = 300; % Room temperature (K)
L = 4.979*2.54e-2;

f0 = om;
om_shift=fsolve(@(X) Zb(X,a,ap,d,dg,t,L,T) + 1i*Xi(X,a,r0)*(1-Zb(X,a,ap,d,dg,t,L,T)),f0,options)
om_shift=fsolve(@(X) Zb_ll(X,a,ap,d,dg,t,L) + 1i*Xi(X,a,r0),f0,options)




