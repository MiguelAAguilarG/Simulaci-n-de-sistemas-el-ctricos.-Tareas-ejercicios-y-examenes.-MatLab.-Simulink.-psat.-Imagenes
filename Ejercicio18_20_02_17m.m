clear all;
clc;

m=0.5;
b=0.00411;
c=155.2;

f=@(t,x) [x(2); (-b*sign(x(2))*(x(2))^2-c*x(1))/m];
[T,X]=ode45(f, [0 100], [1 0]);

plot(T,X(:,1));