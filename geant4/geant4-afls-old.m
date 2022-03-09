


[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-si-31.txt');
%x = x .* 2.034 - 1.881;
plot(x, (y) , '.-b', 'DisplayName', '31 кэВ'); hold on;

[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-si-81.txt');
%x = x .* 2.034 - 1.881;
plot(x, (y), '.-r', 'DisplayName', '81 кэВ'); hold on;

[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-si-356.txt');
%x = x .* 2.034 - 1.881;
plot(x, (y), '.-k', 'DisplayName', '356 кэВ'); hold on;

figure(2);

[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-bgo-31.txt');
x = x .* 1.15 - 6.054;
plot(x, log10(y) , '.-b', 'DisplayName', '31 кэВ'); hold on;

[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-bgo-81.txt');
x = x .* 1.15 - 6.054;
plot(x, log10(y), '.-r', 'DisplayName', '81 кэВ'); hold on;

[x, y] = loadXY('/home/fna/data/geant/ba_dose/old/old/afls/afl-bgo-356.txt');
x = x .* 1.15 - 6.054;
plot(x, log10(y), '.-k', 'DisplayName', '356 кэВ'); hold on;



xlabel('Количество фотонов, N');
ylabel('Интенсивность, I');

legend('show');


x = [ 31 81 356];
y = [ 61.17 162.9 722.2];
plot(x, y, '.-b', 'DisplayName', 'y = 2.034*x - 1.865');

xlabel('Энергия, кэВ');
ylabel('Интенсивность, I');

legend('show');






