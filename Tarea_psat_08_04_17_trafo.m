%	bus	bus	voltage	angle	----Load----	-----Generator-----Injected
%	No	code	mag	degree	MW	Mvar	MW	Mvar	Qmin	Qmax	Mvar	
busdata=[1	1 	1.01	0	0	0	0	0	0	0	0
	2	0	1	0	60	35	0	0	0	0	0
	3	0	1	0	70	42-18	0	0	0	0	0
	4	0	1	0	80	50-15	0	0	0	0	0
	5	2	1	0	65	36	190	0	0	0	0
];

%	Bus	bus	R	X	1/2 B	TAP
%	NL	NR	pu	pu	pu
linedata=[1	2	0.0108	0.0649	0	1
	1	4	0.0235	0.0941	0	1
	2	3	0	0.04	0	1/0.975
	2	5	0.0118	0.0471	0	1
	3	5	0.0147	0.0588	0	1
	4	5	0.0118	0.0529	0	1];

Bus.con(:,1) = busdata(:,1);
Bus.con(:,2) = 100;

Line.con(:,1) = linedata(:,1);
Line.con(:,2) = linedata(:,2);
Line.con(:,3) = 100;
Line.con(:,4) = 100;
Line.con(:,5) = 60;
Line.con(:,6) = 0;
Line.con(:,7) = 0;
Line.con(:,8) = linedata(:,3);
Line.con(:,9) = linedata(:,4);
Line.con(3,11) = 1/0.975;

%         1  2   3    4  5      
SW.con = [1 100 100 1.01 0 ];

%         1  2   3   4   5      
PV.con = [5 100 100  1.9 1];

PQ.con(:,1) = busdata(2:5,1);
PQ.con(:,2) = 100;
PQ.con(:,3) = 100;
PQ.con(:,4) = busdata(2:5,5)./100;
PQ.con(:,5) = busdata(2:5,6)./100;
