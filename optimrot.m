
angles = {'0.025', '0.05', '0.075', '0.1', '0.2', '0.3', '0.5'};

out = zeros(numel(angles), 1);
center = zeros(numel(angles), 1);
periphery = zeros(numel(angles), 1);

for a=1:numel(angles)
    [raw] = loadMetaImage(sprintf('c:/scans/test13/%s/V/slice.mha', char(angles(a))));
    %imagesc(raw)

    center(a) = (calcSNR(raw, 1664, 1437, 50) + calcSNR(raw, 1648, 1991, 50) + calcSNR(raw, 1202, 1552, 50) + calcSNR(raw, 1995, 1615, 50)) / 4;
    periphery(a) = (calcSNR(raw, 434, 1667, 50) + calcSNR(raw, 2961, 1657, 50) + calcSNR(raw, 1623, 500, 50) + calcSNR(raw, 1631, 2816, 50)) / 4;
    out(a) = calcSNR(raw, 896, 3172, 20);
end

plot(1:numel(angles), center, '.-b', 'DisplayName', 'center'); hold on;
plot(1:numel(angles), periphery, '.-r', 'DisplayName', 'periphery'); hold on;

xticklabels(angles);

xlabel('Angle step, degrees');
ylabel('SNR');

legend('show');


