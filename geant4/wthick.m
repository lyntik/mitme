index = 1;
%thicks=[1 2 3 4 5 6 7 8 10 50 100]

thicks=[1 2 3 4 5 6 7 8 10]
totalen = zeros(numel(thicks), 1);
for t = thicks
    [x, y] = loadXY(sprintf('/home/fna/dev/wthick/build/out/1/inc_%.3f_0.txt', t / 1000));
    
    totalen(index) = sum(x .* y);
    index = index + 1;
end

plot(thicks, totalen, '.-b'); hold on;


return;

figure('rend', 'painters', 'pos', [500 500 1100 800]);
suptitle({sprintf('inc/deposit spectrum, exposure %.3f seconds', seconds),''})
subplot(2,1,1);

[x, y] = loadXY('/home/fna/dev/wthick/build/out/inc_0.txt');
plot(x, y , '.-g', 'DisplayName', 'inc'); hold on;

   
title('linear');
xlabel('Energy, keV');
ylabel('Counts, N');
legend('show');

subplot(2,1,2);
[x, y] = loadXY('/home/fna/dev/wthick/build/out/inc_0.txt', true);
plot(x, y , '.-g', 'DisplayName', 'inc'); hold on;



title('log10');
xlabel('Energy, keV');
ylabel('Counts, N');
legend('show');

legend('show');