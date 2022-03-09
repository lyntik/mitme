
% colorIndex = 1;
%     e = 1;
% %     [x, y] = loadXY('/home/fna/dev/geant4/resist/build/out/0_distr.txt');
% %     %y = y(1:501);
% %     plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%dMeV', e)); hold on;
% %     sum(y)
%     
%     colorIndex = colorIndex + 1;
%     [x, y] = loadXY('/home/fna/dev/geant4/resist/build/out/1MeV_distr.txt');
%     %y = y(1:501);
%     plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%dMeV', e)); hold on;
%     sum(y)
%     
%     
%     return;

colorIndex = 1;

% I
q = 1.6*10^-19;
N = 500000;
t = 1;
I = N*q/t;
Ireal = 10^-3;
%seconds = I/Ireal;
seconds = I/Ireal;

p = 5.32;
thick = 0.5;
m = thick * 10 * 10 * 10^-3 * p / 1000; % in kg

grey = 10^3 * 1.6021766209 * 10^-19 / m *     3600 / seconds;

dose = zeros(5, 1);
for e=1:5
    [x, y] = loadXY(sprintf('/home/fna/dev/geant4/resist/build/out/%dMeV.txt', e));
    dose(e) = sum(x.*y)*grey;
    
%     plot(x, log(y), char(colors(colorIndex)), 'DisplayName', sprintf('%dMeV', e)); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end       

    
    [x, y] = loadXY(sprintf('/home/fna/dev/geant4/resist/build/out/%dMeV_distr.txt', e));
    %y = y(1:500);
    plot(1:50, y, char(colors(colorIndex)), 'DisplayName', sprintf('%dMeV', e)); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end          
   
end

title('energy deposition distribution');
legend('show');

%title('deposit, log');
%legend('show');

% bar(1:5, dose);
% title('dose, 1ma');
% xlabel('Energies, MeV');
% ylabel('Dose, grey/hour');

print('-clipboard','-dbitmap');

return;

