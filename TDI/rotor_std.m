

figure(1);
imagesc(imgs(:, :, 5));

SNRs = zeros(6, 1);
index = 1;

%SNRs(1) = 


proj = 100;
img = loadTXTMatrix(sprintf('%s/tdi%04d.txt', path, proj), 256, 256 );
%imagesc(img);
ind = zeros(size(img, 1), size(img, 2), 'logical');
%ind(115:125, 95:125) = 1;
ind(182:192, 160:180) = 1;
SNRs(index) = mean(img(ind)) / std(img(ind));
index = index + 1;


for imgInd=[1 2 3 4 5]
    
    ind = zeros(size(imgs, 1), size(imgs, 2), 'logical');
    %ind(17:27, 70:100) = 1;
    ind(85:95, 140:160) = 1;
   
    img = imgs(:, :, imgInd);
    
    SNRs(index) = mean(img(ind)) / std(img(ind));
    index = index + 1;
    
%      if (imgInd == 3)
%          ind = zeros(size(img2, 1), size(img2, 2), 'logical');
%          ind(187:197, 122:142) = 1;
%          SNRs(index) = mean(img2(ind)) / std(img2(ind));
%          index = index + 1;
%      end
end

plot(1:6, SNRs, '.-b');
% xticklabels({'16', '32', '64', 'static-100', '128'});

x = [1 16 32 64 128 256];




[xData, yData] = prepareCurveData( x, SNRs );

% Set up fittype and options.
ft = fittype( 'a*sqrt(2)^log2(x)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = 0.970592781760616;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'SNRs vs. x', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'x', 'Interpreter', 'none' );
ylabel( 'SNRs', 'Interpreter', 'none' );
grid on

xFit = 0.1:0.1:300;
yFit = zeros(numel(xFit), 1);
yInd = 1;
for i = xFit
    yFit(yInd) = feval(fitresult, i);
    yInd = yInd + 1;
end


plot(x, SNRs, 'o', 'DisplayName', 'TDI'); hold on;
plot(100, 126.5, '*', 'DisplayName', 'static'); hold on;
plot(xFit, yFit, '.-r', 'DisplayName', 'fit a*sqrt(2)\^log2(x)'); hold on;
xlabel('Number of columns');
ylabel('SNR');
legend('show');


