function alpha = alpha_te11(om,a,mu,eps,tand,sig)
% Calculates the losses in a cylindrical waveguide in Np/m
% Inputs:
% - om: wave frequency in rad/s
% - mu: permeability of medium in SI
% - eps: permittivity of medium in SI
% - a: radius of the waveguide

pp11 = 1.841;

% Conduction losses
k = wg_wavenumber(om,mu,eps);
eta = mat_impedance(mu,eps);
beta = beta_te11(om,a,mu,eps);
rs = surface_rs(om,mu,sig);

ac = rs * 1/(a*k*eta*beta)*( (pp11/a)^2 + k^2/(pp11^2-1));

% Dielectric losses
ad = k^2*tand/(2*beta) ;

% Overall losses
alpha = ac + ad;

