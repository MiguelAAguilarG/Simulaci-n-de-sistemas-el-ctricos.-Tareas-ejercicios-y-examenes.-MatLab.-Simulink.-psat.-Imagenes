G=tf([1],[1 2]);

figure;
step(G);

t=0:0.1:20;
u=t;
[Y,X]=lsim([1],[1 2],u,t);
figure;
hold on;
plot(t,Y);
plot(t,u,'r');

figure;
impulse(G);