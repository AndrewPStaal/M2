R = ZZ/101[x,y];
m = ideal vars R
M = m/m^3
C = resolution M
h = resolution map(M, m^2/m^4)
