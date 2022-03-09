


energyPlasma = 0.011;

betta = 1;
c = 3 * 10^8;
h = 6.58 * 10^-19;
%d = (0.668 / 2) * 10 ^-9 *1.0 ;
%d = (0.668 / 2) * 10 ^-9 *1.0 ;
d = (0.54) * 10 ^-9 *1.0/sqrt(3) ;
QB = 5 ;
energyBragg = 2 * pi * h * c / (2*d * sin(QB*pi/180) )
epsilon = 1 - (energyPlasma^2 / energyBragg ^ 2);
syms Q
hw(Q) = (2*pi* h*c/d)*( betta*sin(QB*pi/180) / (1 - sqrt(epsilon) * betta * cos(Q*pi/180)));

double(hw(10))
%return;
% syms Q
% hwB(Q) = 2 * pi * h * c / (d * sin(QB) )
Q = [8:0.5:9.5 9.75 10:0.5:11] ;
%Q = Q + 0.25
Q = Q + 1


%return;
y = zeros(numel(Q), 1);
for i=1:numel(Q)
    y(i) = hw(Q(i));
end
plot(Q, y, '.-k', 'DisplayName', 'PRI Model'); hold on;

%return;

syms Q
%hw(Q) = (2*pi* h*c/d)* cos(QB*pi/180) / sin(Q*pi/180);
hw(Q) = (2*pi* h*c/d)  / (2 *sin((Q-QB)*pi/180)) ;
Q = [8:0.5:9.5 9.75 10:0.5:11] ;
Q = Q + 0.25
y = zeros(numel(Q), 1);
for i=1:numel(Q)
    y(i) = hw(Q(i));
end
plot(Q, y, '.-r', 'DisplayName', 'Model sin(Q-QB)'); hold on;



syms Q
hw(Q) = (2*pi* h*c/d)* cos(QB*pi/180) / sin(Q*pi/180);
Q = [8:0.5:9.5 9.75 10:0.5:11] ;
Q = Q + 0.25
y = zeros(numel(Q), 1);
for i=1:numel(Q)
    y(i) = hw(Q(i));
end
plot(Q, y, '.-g', 'DisplayName', 'Model X-ray'); hold on;


syms Q
hw(Q) = (2*pi* h*c/d) / (2 * sin(Q/2*pi/180));
Q = [8:0.5:9.5 9.75 10:0.5:11] ;
%Q = Q + 0.25
Q = Q + 1
y = zeros(numel(Q), 1);
for i=1:numel(Q)
    y(i) = hw(Q(i));
end
plot(Q, y, '.-r', 'DisplayName', 'Classic Bragg Model'); hold on;


syms delta
hw(delta) = -delta*pi/180*cot(QB*pi/180);
Q = [8:0.5:9.5 9.75 10:0.5:11] ;
Q = Q + 0.25
delta = Q - 10;

y = zeros(numel(Q), 1);
for i=1:numel(Q)
    y(i) = energyBragg * (1 + hw(delta(i))) ;
end
plot(Q, y, '.-m', 'DisplayName', 'New'); hold on;


% 
% syms QB
% Q = 10;
% hw(QB) = (2*pi* h*c/d)*( betta*sin(QB*pi/180) / (1 - sqrt(epsilon) * betta * cos(Q*pi/180)));
% %hw(QB) = (2*pi* h*c/d)* cos(QB*pi/180) / sin(Q*pi/180);
% %hw(QB) = (2*pi* h*c/d) / (2 *sin(QB*pi/180));
% QB = [ 8.2500    8.7500    9.2500    9.7500   10.0000   10.2500   10.7500   11.2500];
% QB = QB ./ 2;
% y = zeros(numel(QB), 1);
% for i=1:numel(QB)
%     y(i) = hw(QB(i));
% end
% plot(QB, y, '.-k', 'DisplayName', 'PRI'); hold on;
% legend('show');


%%% exp

y_experimental = [25.68 23.98 22.89 21.8 21.22 20.79 19.84 19.02];
plot(Q, y_experimental, '.-b', 'DisplayName', 'Experiment'); hold on;

legend('show');


title({''}); xlabel('Bragg angle, deg'); ylabel('Energy, keV'); legend('show');