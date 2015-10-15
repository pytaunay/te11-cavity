function beta = beta_te11( om , a,mu , eps)
% Calculate the propagation constant with no losses
% for the TE11 mode in a cylindrical waveguide of radius a
% Inputs
% - om: wave frequency in rad/s
% - mu: permeability of medium in SI
% - eps: permittivity of medium in SI
% - a: radius of the waveguide

pp11 = 1.841;

beta = sqrt( wg_wavenumber(om,mu,eps)^2 - (pp11/a)^2);

end
