function Zwg = wg_impedance_te11(om,a,mu,eps)
% Waveguide impedance TE11

k = wg_wavenumber(om,mu,eps);
eta = mat_impedance(mu,eps);
beta = beta_te11(om,a,mu,eps);


Zwg = k*eta/beta;

end 
