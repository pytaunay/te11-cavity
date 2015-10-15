function rs = surface_rs(om, mu, sig)
% Calculates the surface resistivity of a waveguide
% Inputs
% - om: wave frequency
% - sig: conductivity of waveguide material
% - mu: permeability of medium

rs = sqrt(om*mu/(2*sig));

end
