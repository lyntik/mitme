
seconds = (2240000000 / 2.5378) / (370000000 * 0.7);

figure('rend', 'painters', 'pos', [500 500 1100 800]);
suptitle({sprintf('inc/deposit spectrum, exposure %.3f seconds', seconds),''})
subplot(2,1,1);

[x, y] = loadXY('/home/fna/dev/ba2/build/out/inc_0.txt');
plot(x, y , '.-g', 'DisplayName', 'inc'); hold on;

[x, y] = loadXY('/home/fna/dev/ba2/build/out/deposit_0.txt');
plot(x, y , '.-k', 'DisplayName', 'deposit'); hold on;
   
title('linear');
xlabel('Energy, keV');
ylabel('Counts, N');
legend('show');

subplot(2,1,2);
[x, y] = loadXY('/home/fna/dev/ba2/build/out/inc_0.txt', true);
plot(x, y , '.-g', 'DisplayName', 'inc'); hold on;

[x, y] = loadXY('/home/fna/dev/ba2/build/out/deposit_0.txt', true);
plot(x, y , '.-k', 'DisplayName', 'deposit'); hold on;

title('log10');
xlabel('Energy, keV');
ylabel('Counts, N');
legend('show');

legend('show');
