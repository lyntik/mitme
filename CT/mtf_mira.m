
% x = [412 951 1265 1481 1740 1907 2025 2096 2151 2204 2241];
% lp = [1.5 2 2.5 3 4 5 6 7 8 9 10];
x = [650 869 1135 1300 1400 1487 1541 1584 1627 ];
lp = [2 3 4 5 6 7 8 9 10];
% x = [650];
% lp = [2];

mtf = zeros(numel(lp), 1);

for i=1:numel(lp)

    piece = imageData(575:610, x(i));
    %plot(x, piece, '.-b');

    [pks] = findpeaks(single(piece));
    I1 = median(pks)
    [pks] = findpeaks(-single(piece));
    I2 = -median(pks)

    %mtf(i) = abs(I1-I2) / (I1+I2);
    mtf(i) = abs(I1-I2) / I1;
end    

plot(lp, mtf, '.-b'); hold on;
xlabel('Пар линий/мм');
ylabel('Модуляция');
