

%%% RA correction

[raw] = loadMetaImage('/home/fna/scans/oreh/projs16.mha');

coeffs = zeros(256, 256);

figure(3);

for r = 1:256
    sino = raw(:, :, r);

    x = 1:256;
    y = sum(sino, 1);
    [xData, yData] = prepareCurveData( x, y );
    ft = fittype( 'sin1' );
    %if r > 25
    if r > 10
        ft = fittype( 'sin7' );
    end
    
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    [fitresult, gof] = fit( xData, yData, ft, opts );
    
    h = plot( fitresult, xData, yData );
     
%     ff = zeros(256, 1);
%     for x = 1:256
%         ff(x) = feval(fitresult, x);
%     end
%     
%      plot(1:256, ff, '-r', 'DisplayName', 'Подобранная интенсивность'); hold on;
% %     y = sum(slice, 1);
%      plot(1:256, y, '.b', 'DisplayName', 'Оригинальная интенсивность'); hold on;
%      
%     xlabel('Пиксель');
%     ylabel('Суммарная интенсивность, I');
%     legend('show');
    
    for xx = x
        coeffs(r, xx) = feval(fitresult, xx) / y(xx);
    end
       
end    


rawOut = raw;
for y = 1:256
    for z = 1:660
        g = double(rawOut(z, :, y)) .* coeffs(y, :);
        ind = g > 65535;
        g(ind) = 65535;
        rawOut(z, :, y) = g;
    end
end
rawOut = permute(rawOut, [2 3 1]);

fileID = fopen('/home/fna/scans/oreh/projs16_c.mha','w');
fwrite(fileID,rawOut,'ushort');
fclose(fileID);
 

return;

%%% CNR
[raw] = loadMetaImage('/home/fna/scans/oreh/fdk_.mha');
piece = raw(155:170, 118:135, 128);
piece = reshape(piece, [1, 288]);
x = mean(piece);

piece = raw(225:240, 118:135, 128);
piece = reshape(piece, [1, 288]);
y = mean(piece);
C = x - y;
CNR = C / std(piece)

return;

%%% SNR
[raw] = loadMetaImage('/home/fna/scans/oreh/fdk0_.mha');
piece = raw(155:170, 118:135, 128);
piece = reshape(piece, [1, 288]);
mean(piece) / std(reshape(piece, [1, 288]))

[raw] = loadMetaImage('/home/fna/scans/oreh/fdk_.mha');
piece = raw(155:170, 118:135, 128);
piece = reshape(piece, [1, 288]);
mean(piece) / std(reshape(piece, [1, 288]))

return;

%%% Profile edge

[raw] = loadMetaImage('/home/fna/scans/oreh/fdk0_.mha');
z = 205:220;
r0 = raw(z, 132, 128);

[raw] = loadMetaImage('/home/fna/scans/oreh/fdk_.mha');
r = raw(z, 132, 128);


[xData, yData] = prepareCurveData( z, r0 );
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.309432142296985;
[fitresult0, gof] = fit( xData, yData, ft, opts );

[xData, yData] = prepareCurveData( z, r );
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.309432142296985;
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

f0 = zeros(numel(z0), 1);
for i=z
    f0(i - z(1) + 1) = feval(fitresult0, i);
end
f = zeros(numel(z), 1);
for i=z
    f(i - z(1) + 1) = feval(fitresult, i);
end

plot(z, f0, '.-b', 'DisplayName', 'Оригинал'); hold on;
plot(z, f, '.-r', 'DisplayName', 'После коррекции'); hold on;

xlabel('Пиксель');
ylabel('Коэфф. поглощения, см^-1');
legend('show');






    
