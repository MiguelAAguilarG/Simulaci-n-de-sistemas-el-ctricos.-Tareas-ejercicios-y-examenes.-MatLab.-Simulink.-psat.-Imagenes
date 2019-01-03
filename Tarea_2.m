syms t;

y=sin(t);
yi=int(y,t);

hold on;
ezplot(y);
h=ezplot(yi);
set(h,'Color','r');
