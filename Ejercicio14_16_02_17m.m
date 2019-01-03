clear all;
clc;

alpha = -0.3;
betta = 0.04;
delta = -0.03;
gamma = 5;

f=@(t,x) [alpha*x(1) + betta*x(1)*x(2);gamma*x(2) + delta*x(1)*x(2)];
[T,X]=ode45(f, [0 100], [3 100]);

plot(T,X(:,1),T,X(:,2));