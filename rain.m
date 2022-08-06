
rows = 1:50:102;
%rows = rows + 600;

snr = zeros(numel(rows), 1);
ind = 1;

for i=rows

%[raw] = loadMetaImage('d:/scans/rain/al1_6/img4_.mhd');
[raw] = loadMetaImage('d:/scans/rain/al1_mp3/tiffs/corr/img_.mhd');
roi = squeeze(raw(:, i, 1:300))';
%imagesc(raw(:, :, 1));

sinoSum = sum(roi, 1) ./ size(raw, 3);
x = 1:numel(sinoSum);

[coeffs, y] = fito(x, sinoSum, 'poly8');

% ft = fittype( 'sin1' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.Lower = [-Inf 0 -Inf];
% opts.StartPoint = [0.207400238446752 0.000533649168267334 -0.0261106105938564];
% ft = fittype( 'poly9' );
% opts = fitoptions( 'Method', 'LinearLeastSquares' );
% opts.Robust = 'Bisquare';
% 
% 
% [fitresult, gof] = fit( xData, yData, ft, opts );     
% 
% gyk = zeros(numel(profile), 1);
% for i=1:numel(profile)
%     gyk(i) = feval(fitresult, i);
% end
% 

plot(x, sinoSum, '.-b'); hold on;
plot(x, y, '.-r'); hold on;
ylim([0 max(sinoSum) * 1.1])

diff = sinoSum - y';

%std(diff)/mean(sinoSum)*100
%mean(sinoSum)/std(diff)

snr(ind) = mean(sinoSum)/std(diff);
ind = ind + 1;
end


int32(snr)

% r = raw(971:1070, 2175:2256);
% r = reshape(r, [numel(r), 1]);
% mean(r)
% std(r)
% 