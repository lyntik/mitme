function [r] = toenergy(tot)
x = tot;
%r = (tot + 4.54) / 2.424; 
%r = (tot + 1.623) / 2.327; 
%r = 0.214869 * (tot + 32.5374) + 0.0000243096 * sqrt(7.8125 * power(10, 7) * tot * tot - 5.59115 * power(10, 9) * tot + 1.33464 * power(10, 11));
%r = 0.321958*(x-55.163)+3.21958*power(10,-7)*sqrt(power(10,12)*x*x-1.18594*power(10,14)*x+9.48401*power(10,15));

r = 0.321958*(x-55.163)+3.21958*power(10,-7)*sqrt(power(10,12)*x*x-1.18594*power(10,14)*x+9.48401*power(10,15));