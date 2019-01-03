Bus.con(:,1) = xlsread('bus.xlsx', 1, 'A6:A19');
Bus.con(:,2) = 100;

Line.con(:,1) = xlsread('linea.xlsx', 1, 'B8:B27');
Line.con(:,2) = xlsread('linea.xlsx', 1, 'C8:C27');
Line.con(:,3) = 100;
Line.con(:,4) = 100;
Line.con(:,5) = 60;
Line.con(:,8) = xlsread('linea.xlsx', 1, 'D8:D27');
Line.con(:,9) = xlsread('linea.xlsx', 1, 'E8:E27');
Line.con(:,10) = xlsread('linea.xlsx', 1, 'F8:F27');
Line.con(:,10) = Line.con(:,10)*2;
Line.con(8,11) = 0.978;
Line.con(9,11) = 0.969;
Line.con(10,11) = 0.932;

SW.con = [ ... 
% 1    2   3   4    5   6   7       8     9  10 11 12 13
  1  100  100  1.01  0  0.4  0.234  0     0  0  0  0  0;
 ];

PV.con = [ ... 
 %1   2    3   4      5         6     7     8     9     10 11     
  1  100  100  1.1417 1.06      0.1   0     0  0  0  0;
  2  100  100  0.4    1.045     0.5   -0.42 0  0  0  0;
 ];

PQ.con(:,1) = xlsread('bus.xlsx', 1, 'A7:A19');
PQ.con(:,2) = 100;
PQ.con(:,3) = 100;
PQ.con(:,4) = xlsread('bus.xlsx', 1, 'F7:F19');% load
PQ.con(:,4) = PQ.con(:,4)/100;
PQ.con(:,5) = xlsread('bus.xlsx', 1, 'G7:G19');
PQ.con(:,5) = PQ.con(:,5)/100;

PQgen.con= [ ...
   1 100.00   100.00  1.1417 -0.169];

Shunt.con=[9 100 100 60 0 0.19];

Bus.names = {... 
  'Bus 01'; 'Bus 02'; 'Bus 03'; 'Bus 04'; 'Bus 05'; 
  'Bus 06'; 'Bus 07'; 'Bus 08'; 'Bus 09'; 'Bus 10'; 
  'Bus 11'; 'Bus 12'; 'Bus 13'; 'Bus 14'};
