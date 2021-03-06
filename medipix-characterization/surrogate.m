
% %%%%%% 8 kEv

% %% 1 cluster
% x = [12 13 15 17 20 25 30 35 40 45];
% y = [37 41 49 55 60 70 80 90 98 109];
% 
x = [13 15 17 20 25 30 35];
y = [54 69 78 92 112 128 144];


syms x
% f(x) = 1.719*x+33-96.84/(x-6);
f(x) = 2.791*x+55.75-273.6/(x-5.759);
g1 = finverse(f)
% 
% %%% 2 cluster
% x = [15 17 20 25 30 35 40 45];
% y = [37 48 60 76 90 100 113 123];
x = [13 15 17 20 25 30 35];
y = [36 47 62 86 115 138 161];

syms x
%f(x) = 1.911*x+45.32-316.4/(x-6.438);
f(x) = 4.863*x-1.916-140.6/(x-8);
g2 = finverse(f)


% %%% 3 cluster
% x = [30 35 40 45];
% y = [70 90 106 119];
% 
% syms x
% f(x) = 2.453*x+34.76-1119/(x-0.02753);
% g3 = finverse(f)
% 

% %%%%%% 6 kEv
x = [10 13 15 17 20 25 30 35];
y = [59 76 90 98 112 131 150 168];

% %% 1 cluster
syms x
f(x) = 2.99*x+80-630.9/(x+2.316);
g1 = finverse(f)

% %% 2 cluster
x = [10 13 15 17 20 25 30 35];
y = [43 72 92 103 128 156 179 204];

f(x) = 2.591*x+189.1-3442/(x+9.985);
g2 = finverse(f)









