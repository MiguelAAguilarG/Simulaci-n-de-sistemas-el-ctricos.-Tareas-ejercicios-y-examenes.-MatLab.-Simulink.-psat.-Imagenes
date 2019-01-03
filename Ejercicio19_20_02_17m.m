clear all;
clc;

g=9.81;
l=10;

f=@(t,x) [x(2); -g/l*sin(x(1))];
[T,X]=ode45(f, [0 100], [pi/4 0]);

plot(T,X(:,1));