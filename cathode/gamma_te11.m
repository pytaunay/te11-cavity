function gamma = gamma_te11(om,a,mu,eps,tand,sig)

alpha = alpha_te11(om,a,mu,eps,tand,sig);
beta = beta_te11(om,a,mu,eps) ;

gamma = alpha + 1i*beta; 


end
