%a
G=tf([1000e-6],[2200*1000e-6 1]);

figure;
step(G);

t=0:0.1:20;
u=t;
[Y,X]=lsim([1000e-6],[2200*1000e-6 1],u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);

[z,p,k]=tf2zp([1000e-6],[2200*1000e-6 1])
%b
G=tf([10e-6],[100e3*10e-6 1]);

figure;
step(G);

t=0:0.1:20;
u=t;
[Y,X]=lsim([10e-6],[100e3*10e-6 1],u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);

[z,p,k]=tf2zp([10e-6],[100e3*10e-6 1])

