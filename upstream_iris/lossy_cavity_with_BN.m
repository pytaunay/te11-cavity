% Model of a lossy cavity made of:
% - An iris
% - A BN cylinder - domain 2
% - A small graphite tube - domain 1
% - A Lab6 cavity - domain 0

tau = 2*pi*0.178;

% Define some materials constants
mu = 4*pi*1e-7;
eps = 8.854e-12;
epsBN = 4*eps;

%rho_graphite = @(T) (1084.6 - 1.994e-1*T+1.6760e-4*T^2-2.4896e-8*T^3)*1e-8;

% Graphite conductivity
p6 = 4.93032694e-8;
p5 = -2.37073764e-7;
p4 = 4.02348501e-7;
p3 = -4.28581428e-7;
p2 = 7.41445484e-7;
p1 = 1.15093741e-6;
p0 = 9.57955994e-6;
T0 = 1112;
Tstd = 789.6;

rho_graphite = @(x) p6*x.^6 + p5*x.^5 + p4*x.^4 + p3*x.^3 + p2*x.^2 + p1*x + p0; 
sig_graphite = @(T) 1./rho_graphite( (T-T0)/Tstd );

% Lab6 from Lafferty
rho_lab6 = @(T) ((120-20)/(1600-200)*T + 5.7142875)*1e-8;
sig_lab6 = @(T) 1/rho_lab6(T);

% Molybdenum
rho_mo = @(T) 3e-10*T-4e-8 
sig_mo = @(T) 1/rho_mo(T);


tand = 3e-4; % BN tangent loss;

% Define propagation constants;
beta0 = @(om,a) beta_te11(om,a,mu,eps);
beta1 = @(om,ap) beta_te11(om,ap,mu,epsBN);

g0 = @(om,a,T) gamma_te11(om,a,mu,eps,0,sig_lab6(T))  ;
g0p = @(om,a,T) gamma_te11(om,a,mu,eps,0,sig_graphite(T))  ;
g0mo = @(om,a,T) gamma_te11(om,a,mu,eps,0,sig_mo(T));
g1 = @(om,ap,T) gamma_te11(om,ap,mu,epsBN,tand,sig_graphite(T))  ;

% Define impedance of circular wg. for both BN and vac.;
Z0 = @(om,a) wg_impedance_te11(om,a,mu,eps);
Z1 = @(om,ap) wg_impedance_te11(om,ap,mu,epsBN);
Z1b = @(om,a,ap) Z1(om,ap)/Z0(om,a);

% Reduced impedance of cavity + BN
% ... in the lossy case
nZL3 = @(om,a,ap,d,dg,t,T) Z1b(om,a,ap)*(tanh(g0(om,a,T)*d + g0p(om,a,T)*dg) + Z1b(om,a,ap)*tanh(g1(om,ap,T)*t)); 
dZL3 = @(om,a,ap,d,dg,t,T) Z1b(om,a,ap) + tanh(g0(om,a,T)*d + g0p(om,a,T)*dg)*tanh(g1(om,ap,T)*t); 
ZL3 = @(om,a,ap,d,dg,t,T) nZL3(om,a,ap,d,dg,t,T) / dZL3(om,a,ap,d,dg,t,T); 

Zb = @(om,a,ap,d,dg,t,L,T) (ZL3(om,a,ap,d,dg,t,T) + tanh(g0mo(om,a,T)*L)) / (1+ZL3(om,a,ap,d,dg,t,T)*tanh(g0mo(om,a,T)*L)); 

% ... in the lossless case
ZL3_ll =  @(om,a,ap,d,dg,t) 1i*Z1b(om,a,ap)*(tan(beta0(om,a)*(d+dg)) + Z1b(om,a,ap)*tan(beta1(om,ap)*t)) ./ (Z1b(om,a,ap) - tan(beta0(om,a)*(d+dg))*tan(beta1(om,ap)*t)); 

Zb_ll = @(om,a,ap,d,dg,t,L) (ZL3_ll(om,a,ap,d,dg,t) + 1i*tan(beta0(om,a)*L)) / (1+1i*ZL3_ll(om,a,ap,d,dg,t)*tan(beta0(om,a)*L)); 

% Reactance of the iris
Xi = @(om,a,r) r.^3*beta_te11(om,a,mu,eps)/(tau*a^2);
