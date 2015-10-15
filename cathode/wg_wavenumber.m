function k = wg_wavenumber(om,mu,eps)
% Calculates the wavenumber in a waveguide
% - om: wave frequency in rad/s
% - mu: permeability of medium in SI
% - eps: permittivity of medium in SI

k = om * sqrt(mu*eps);

end
