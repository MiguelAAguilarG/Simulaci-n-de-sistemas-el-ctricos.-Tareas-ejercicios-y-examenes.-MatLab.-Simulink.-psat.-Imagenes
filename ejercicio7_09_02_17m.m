%Sobreamortiguado
R = 1;
L = 1/4;
C = 4/3;

num = [1/L*C];
den = [1 R/L 1/L*C];
G=tf(num,den);

figure;
step(G);

t=0:0.1:10;
u=t;
[Y,X]=lsim(num,den,u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);

%Subamortiguado
R = 10;
L = 4;
C = 16e-3;

num = [1/L*C];
den = [1 R/L 1/L*C];
G=tf(num,den);

figure;
step(G);

t=0:0.1:10;
u=t;
[Y,X]=lsim(num,den,u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);
%Críticamente amortiguado
R = 4;
L = 2;
C = 1/2;

num = [1/L*C];
den = [1 R/L 1/L*C];
G=tf(num,den);

figure;
step(G);

t=0:0.1:10;
u=t;
[Y,X]=lsim(num,den,u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);