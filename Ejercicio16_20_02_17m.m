clear all;
clc;

f=@(t,y) [y(2); 4*exp(-2*t)-5-3*y(2)-2*y(1)];
[T,Y]=ode45(f, [0 10], [2 -1]);

plot(T,Y(:,1));