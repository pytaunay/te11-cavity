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
%fr = 8.00e9;
fr = 8e9;
om = 2*pi*fr;
d = 1.266*2.54e-2;
%d = 1.4*2.54e-2;

% Set up and solve functional 
f0 = [0.009,0.009];

options = optimoptions('fsolve','Display','iter','TolFun',1e-16,'TolX',1e-16);
%fsolve(@(X)[Ysys_ll(om,a,X(1),d,X(2)),Ysys_l(om,a,X(1),d,X(2))-1],f0,options)


% System recast in a slightly nicer way
res = fsolve(@(X)[Zb_ll(om,a,d,X(2)) + 1i*Xi(om,a,X(1)),Zb(om,a,d,X(2)) + 1i*Xi(om,a,X(1))*(1-Zb(om,a,d,X(2)) )],f0,	options)	
%res = fsolve(@(X)[Zb_ll(om,a,d-X(2),X(2)) + 1i*Xi(om,a,X(1)),Zb(om,a,d-X(2),X(2)) + 1i*Xi(om,a,X(1))*(1-Zb(om,a,d-X(2),X(2)) )],f0,	options)	

%fsolve(@(X)[Zb_ll(om,a,X(1),X(2)) + 1i*Xi(om,a,r0),Zb(om,a,X(1),X(2)) + 1i*Xi(om,a,r0)*(1-Zb(om,a,X(1),X(2)) )],f0,	options)	
	
%Zb_ll =  @(om,a,d,t)
%Xi = @(om,a,r)
