% Model of a lossy cavity made of:
% - An iris
% - A BN cylinder - domain 1
% - A cavity - domain 0

mu = 4*pi*1e-7;
eps = 8.854e-12;
epsBN = 4*eps;

tau = 2*pi*0.178;

sig = 3.5e7; % Aluminum;
sigBN = sig/4; 
tand = 3e-4; % BN tangent loss;

% Define propagation constants;
beta0 = @(om,a) beta_te11(om,a,mu,eps);
beta1 = @(om,a) beta_te11(om,a,mu,epsBN);

g0 = @(om,a) gamma_te11(om,a,mu,eps,0,sig)  ;
g1 = @(om,a) gamma_te11(om,a,mu,epsBN,tand,sigBN)  ;

% Define impedance of circular wg. for both BN and vac.;
Z0 = @(om,a) wg_impedance_te11(om,a,mu,eps);
Z1 = @(om,a) wg_impedance_te11(om,a,mu,epsBN);
Z1b = @(om,a) Z1(om,a)/Z0(om,a);

% Reduced impedance of cavity + BN
% ... in the lossy case
Zb = @(om,a,d,t) Z1b(om,a)*(tanh(g0(om,a)*d) + Z1b(om,a)*tanh(g1(om,a)*t)) ./ (Z1b(om,a) + tanh(g0(om,a)*d)*tanh(g1(om,a)*t)); 

% ... in the lossless case
Zb_ll =  @(om,a,d,t) 1i*Z1b(om,a)*(tan(beta0(om,a)*d) + Z1b(om,a)*tan(beta1(om,a)*t)) ./ (Z1b(om,a) - tan(beta0(om,a)*d)*tan(beta1(om,a)*t)); 

% Reactance of the iris
Xi = @(om,a,r) r.^3*beta_te11(om,a,mu,eps)/(tau*a^2);

% Admittance of the system
% ... lossless
Ysys_ll = @(om,a,r,d,t) 1./(1i*Xi(om,a,r)) + 1./Zb_ll(om,a,d,t);

% ... lossy
Ysys_l = @(om,a,r,d,t)  1./(1i*Xi(om,a,r)) + 1./Zb(om,a,d,t);

