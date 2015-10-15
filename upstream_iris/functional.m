function F = functional(om,a,r,d,t)

F(1) = Ysys_ll(om,a,r,d,t)
F(2) = Ysys_l(om,a,r,d,t)-1

end
