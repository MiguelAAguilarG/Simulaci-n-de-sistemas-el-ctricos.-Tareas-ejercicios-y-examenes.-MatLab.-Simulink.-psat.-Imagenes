clear all;
clc;

A=0.08;
B=0.05;
C=0.5;   
D=0.01;
F0=0.01;

T01=280;
T02=350;

f=@(t,y) [A*(y(1)-T01)*F0-B*(y(1)-y(2));C*(y(2)-T02)*F0+D*(y(2)-y(1))];
[T,Y]=ode45(f, [0 100], [280 350]);

plot(T,Y(:,1),T,Y(:,2));