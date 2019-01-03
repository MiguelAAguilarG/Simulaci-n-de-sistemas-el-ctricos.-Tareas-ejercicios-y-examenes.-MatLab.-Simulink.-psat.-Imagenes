clear all
clc
format short
%************************************
%Nodos pv (es un vector renglón)
nodospv=[4];
iter=10;
maxerror=0.0001;
%El nodo slack siempre debe de ser el nodo 1
%La reactancia capacitiva se deja sin signo negativo
%Potencias de carga (negativas), Potencias de generacion (positivas)
%Poner siempre valores de capacitancia en paralelo, aunque sea solo 0;
%Poner siempre valores de relacion de tranformación, de 1;

z(1,2)=0.01008+0.05040j;
z(1,3)=0.00744+0.03720j;
z(2,4)=0.00744+0.03720j;
z(3,4)=0.01272+0.06360j;

c=zeros(4);
c(1,2)=1/(2*0.05125j);
c(1,3)=1/(2*0.03875j);
c(2,4)=1/(2*0.03875j);
c(3,4)=1/(2*0.06375j);

%Stevenson toma al reves
rel=ones(4);

v(1)=1.0+0j;
v(2)=1.0+0j;
v(3)=1.0+0j;
v(4)=1.02+0j;

poti(1)=-0.5;
poti(2)=-1.7;
poti(3)=-2.0;
poti(4)=3.18-0.80;

qi(1)=-0.3099;
qi(2)=-1.0535;
qi(3)=-1.2394;
qi(4)=-0.4958;

%************No modificar************
nodos=[1 nodospv];
nodos=sort(nodos);
auxnodos=nodos;

tamz=size(z);
%Iguala las impedancias con los indices opuestos
for(r=1:max(tamz))
	for(s=1:max(tamz))
        if z(r,s) ~= 0
		z(s,r)=z(r,s);
        end
	end
end

for(r=max(tamz):-1:1)
	for(s=max(tamz):-1:1)
        if z(r,s) ~= 0
		z(s,r)=z(r,s);
        end	
	end
end
z

%Iguala las relaciones de tranformación con los indices opuestos
aorig=rel;

for(r=1:max(tamz))
	for(s=1:max(tamz))
        if rel(r,s) ~= 1
		rel(s,r)=rel(r,s);
        end
	end
end

for(r=max(tamz):-1:1)
	for(s=max(tamz):-1:1)
        if rel(r,s) ~= 1
		rel(s,r)=rel(r,s);
        end	
	end
end
aorig
rel

%Saca las admitancias (excepto los de indices rr)
for(r=1:max(tamz))
	for(s=1:max(tamz))
		if r~=s
		if z(r,s) ~= 0
		y(r,s)=-1/z(r,s);
        y(r,s)=y(r,s)/rel(r,s);
		end
		end
	end
end

%Saca la matriz de reactancia capacitiva

for(r=1:max(tamz))
	for(s=1:max(tamz))
        if c(r,s) ~= 0
		c(s,r)=c(r,s);
        end
	end
end

for(r=max(tamz):-1:1)
	for(s=max(tamz):-1:1)
        if c(r,s) ~= 0
		c(s,r)=c(r,s);
        end	
	end
end
c

yc=zeros(max(tamz));
for(r=1:max(tamz))
	for(s=1:max(tamz))
        if c(r,s) ~= 0
		yc(r,s)=1/c(r,s);
        end
	end
end

sumc=sum(sum(c));
if sumc ~= 0
yc
else
yc=zeros(max(tamz))
end

yc2=zeros(max(tamz));
for(r=1:max(tamz))
	for(s=1:max(tamz))
        if c(r,s) ~= 0
		yc2(r,s)=yc(r,s)/2;   
        end
	end
end

if sumc ~= 0
yc2
else
yc2=zeros(4)
end

%Saca las admitancias con los indices rr
for(r=1:max(tamz))
	for(s=1:max(tamz))
		if r~=s
        if z(r,s) ~= 0
        yrr(r,s)=1/z(r,s);
		y(r,r)=yrr(r,s)/(aorig(r,s)^2)+y(r,r)+yc2(r,s);
        end
		end
	end
end

y
y(4,4)=y(4,4)+0.1j;
y
%++++++++++++++++++++++++++++++++++++++++++++++++++++
v
tamv=size(v);
tamy=size(y);

for(r=1:max(tamv))
		deltar(r)=angle(v(r));
		deltad(r)=rad2deg(angle(v(r)));
end

for(r=1:max(tamy))
	for(s=1:max(tamy))
		thetar(r,s)=angle(y(r,s));
		thetad(r,s)=rad2deg(angle(y(r,s)));
	end
end

%*************Aqui enpiezan las iteraciones++++++++++++++++++++++++
cont=1;
error=100;
auxv=v(1);
auxdr=angle(v(1));
auxdd=rad2deg(angle(v(1)));
while cont <= iter && error>=maxerror,
disp('*************************************************************');
tamv=size(v);
tamy=size(y);

cont
v

thetar
thetad
deltar
deltad

for(r=1:max(tamy))
    v(r)=abs(v(r));
	g=v(r);

	h=genvarname(['abssv']);
	eval([h, '=g']);

	auxabssv=sym(h,[1,r]);

	h=genvarname([strcat('abssv',num2str(r))]);
	eval([h, '=g']);
end

auxabssv

for(r=1:max(tamy))
	for(s=1:max(tamy))
		g=y(r,s);

		h=genvarname(['sy']);
		eval([h, '=g']);

		auxsy=sym(h,[r,s]);

		h=genvarname([strcat('sy',num2str(r),'_',num2str(s))]);
		eval([h, '=g']);
	end
end

auxsy

for(r=1:max(tamy))
	for(s=1:max(tamy))
		g=thetar(r,s);

		h=genvarname(['sthetar']);
		eval([h, '=g']);

		auxsthetar=sym(h,[r,s]);

		h=genvarname([strcat('sthetar',num2str(r),'_',num2str(s))]);
		eval([h, '=g']);
	end
end

auxsthetar

for(r=1:max(tamy))

	g=deltar(r);

	h=genvarname(['sdeltar']);
	eval([h, '=g']);

	auxsdeltar=sym(h,[1,r]);

	h=genvarname([strcat('sdeltar',num2str(r))]);
	eval([h, '=g']);
end

auxsdeltar
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
syms p q

for(a=1:max(tamy))
p(1,a)=0;
q(1,a)=0;
for(b=1:max(tamy))
fp(1,b)=auxabssv(1,a)*auxabssv(1,b)*abs(auxsy(a,b))*cos(auxsthetar(a,b)-auxsdeltar(1,a)+auxsdeltar(1,b));
fq(1,b)=-1*auxabssv(1,a)*auxabssv(1,b)*abs(auxsy(a,b))*sin(auxsthetar(a,b)-auxsdeltar(1,a)+auxsdeltar(1,b));

p(1,a)=fp(1,b)+p(1,a);
q(1,a)=fq(1,b)+q(1,a);
end
end

pp=eval(p)
qq=eval(q)

x1=jacobian(p,auxsdeltar);
x11=jacobian(p,auxabssv);
x2=jacobian(q,auxsdeltar);
x22=jacobian(q,auxabssv);

x=[x1 x11;x2 x22];

x

jacobiano=eval(x)
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

for(a=1:max(tamy))
    a
    potenciai=poti(a)
    potencianew=eval(p(1,a))
    potenciareaci=qi(a)
    potenciareacnew=eval(q(1,a))

    deltap(a,1)=poti(a)-eval(p(1,a));
    deltaq(a,1)=qi(a)-eval(q(1,a));

end

deltapq=[deltap; deltaq];
deltapq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for(a=1:max(size(nodos)))
    if a==1
    deltapq(1,:)=[];
    deltapq(max(tamy),:)=[];
    
    jacobiano(1,:)=[];
    jacobiano(max(tamy),:)=[];
    jacobiano(:,1)=[];
    jacobiano(:,max(tamy))=[];
    
        for(r=1:max(size(nodos)))
        nodos(r)=nodos(r)-2;
        end
    else   
    deltapq(max(tamy)+nodos(a),:)=[];
    
    jacobiano(max(tamy)+nodos(a),:)=[];
    jacobiano(:,max(tamy)+nodos(a))=[];
    
        for(r=1:max(size(nodos)))
        nodos(r)=nodos(r)-1;
        end
    end
end


%**************************************************
jacobiano
deltapq

deltadv=inv(jacobiano)*deltapq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nodos=auxnodos;
deltadv=[0; deltadv];

for(r=1:max(tamy))
for(s=1:max(size(nodos)))
    if r==nodos(s)
	auxdeltadv=deltadv;
	www=max(size(auxdeltadv))+1;
	deltadv(tamy+r)=0;
		for(a=tamy+r+1:www)
			deltadv(a)=auxdeltadv(a-1);
		end
    end
end
end

deltadv
for(a=1:tamy)
deltar(a)=deltar(a)+deltadv(a);
end

deltar
for(a=tamy+1:2*tamy)
v(a-tamy)=v(a-tamy)+deltadv(a,1);
end
angulo=rad2deg(deltar);
angulo
v
%*************************************************************************
error=max(abs(deltapq));
cont=cont+1;
end
cont=cont-1;
cont
for(a=1:max(size(v)))
    vol(a)=v(a)*exp(i*deltar(a));
end
vol

cor=zeros(max(size(v)));
for(r=1:max(size(v)))
    for(s=1:max(size(v)))
    if r~=s
        if yc2(r,s)~=0 && cor(s,r)==0 && z(r,s)~=0
        cor(r,s)=(vol(r)-vol(s)*rel(r,s))/z(r,s)/rel(r,s)^2+vol(r)*yc2(r,s)/rel(r,s)^2;
        elseif yc2(r,s)==0 && cor(s,r)==0 && z(r,s)~=0
        cor(r,s)=(vol(r)-vol(s)*rel(r,s))/z(r,s)/rel(r,s)^2;
        end
    end
    end
end
cor
for(s=1:max(size(v)))
    for(r=1:max(size(v)))
    if r~=s
        if yc2(r,s)~=0 && cor(r,s)==0 && z(r,s)~=0
        cor(r,s)=(vol(r)-vol(s)/rel(r,s))/z(r,s)+vol(r)*yc2(r,s);
        elseif yc2(r,s)==0 && cor(r,s)==0 && z(r,s)~=0
        cor(r,s)=(vol(r)-vol(s)/rel(r,s))/z(r,s);
        end
    end
    end
end
cor

for(r=1:max(size(v)))
    for(s=1:max(size(v)))
    if r~=s
    scomlinea(r,s)=vol(r)*conj(cor(r,s));
    end
    end
end
scomlinea

for(r=1:max(size(v)))
    for(s=1:max(size(v)))
    if r~=s
    scomperdidas(r,s)= scomlinea(r,s)+ scomlinea(s,r);
    end
    end
end
scomperdidas

for(a=1:max(size(v)))
    scomnodos(a)=0;
end

for(r=1:max(size(v)))
    for(s=1:max(size(v)))
    if r~=s
    scomnodos(r)=scomlinea(r,s)+scomnodos(r);
    end
    end
end

scomnodos