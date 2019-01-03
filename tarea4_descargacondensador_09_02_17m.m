t = [0 10];
q0 = 10;
R = 2;
C = 0.8;
[t,q] = ode45(@(t,q) -q/(R*C), t, q0);

plot(t,q);
title('Descarga de un capacitor (q), q0=10');