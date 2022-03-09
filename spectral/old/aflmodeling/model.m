
global lastEnergy;
lastEnergy = 0;

% [poly] = polychrome();
% plot(15:55, poly, '.-r');
% 
% 
% return;

colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };




% 
% index = 1;
% for e = 25:10:55
%     [afl] = piecewiseBuild(e);
%     plot(15:55, afl, char(colors(index)), 'DisplayName', sprintf('%d kEv corrupted', e)); hold on;
%     index = index + 1;
%     if (index == 8) index = 1; end
% end
% 
% legend('show');
% 
% print(sprintf('plots/afl_corrupted'), '-dpng');
% 
% return;



% e = 25;
% ds = dataset('File',sprintf('thrafl/%d.txt', e));
% dd = double(ds);
% x = dd(:,1)';
% y = dd(:,2)';
% 
% to = 0;
% for i = 1:size(y,2)
%     if (y(i) == 0) 
%         to = i;
%         break;
%     end
% end
% 
% 
% x = x(1:to);
% y = y(1:to);
% 
% %x = [10 x];
% %y = [y(1) y];
% 
% %y(3) = 0.16;
% 
% figure(1);
% plot(x, y, '.-r'); hold on;
% 
% 
% ds = dataset('File',sprintf('thrafl/%dold.txt', e));
% dd = double(ds);
% x = dd(:,1)';
% y = dd(:,2)';
% 
% to = 0;
% for i = 1:size(y,2)
%     if (y(i) == 0) 
%         to = i;
%         break;
%     end
% end
% 
% 
% x = x(1:to);
% y = y(1:to);
% 
% %x = [10 x];
% %y = [y(1) y];
% 
% %y(3) = 0.16;
% 
% figure(1);
% plot(x, y, '.-b'); hold on;
% 
% return;

% 
% [afl] = piecewiseBuild(47);
% plot(14.75:0.5:63.75, afl, '.-b');
% return;

coeffsCollect = zeros(4, 5);

index = 1;


for ee = [ 30:30 ]
    e = ee ;
    %if (e == 16) continue; end
    
    ds = dataset('File',sprintf('thrafl/%d_1.txt', e));
    dd = double(ds);
    x = dd(:,1)';
    y = dd(:,2)';
    
    to = 0;
    for i = 1:size(y,2)
        if (y(i) == 0) 
        %if (x(i) == 44) 
            to = i;
            break;
        end
    end
    
    
    x = x(1:to);
    y = y(1:to);
    
    %x = [10 x];
    %y = [y(1) y];
    
    %y(3) = 0.16;
    
    figure(1);
    plot(x, y, char(colors(index+0)), 'DisplayName', sprintf('AFL %d keV (good statistic)', e)); hold on;
    index = index + 1;
    if (index == 8) index = 1; end
    
    continue;
    

    
    return;
    
%%%%%%%%%%%    
    
    [xData, yData] = prepareCurveData( x, y );
    Set up fittype and options.
    ft = fittype( 'poly4' );
    opts = fitoptions( ft );
    opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf];
    opts.Upper = [Inf Inf Inf Inf Inf Inf];
    Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );
    
    rsquare = gof.rsquare;
    disp(sprintf('%d: %.4f ', e, rsquare));

    coeffsCollect(index, :) = coeffvalues(fitresult);
    
    figure(1);
    plot(x, y, '.-b'); hold on;
    
    figure(1);
    plot(fitresult, char(colors(index))); hold on;
    
    return;

    
    
    figure(2);
    plot(x, y, char(colors(index)), 'DisplayName', sprintf('%d kEv', e)); hold on;
    
    index = index + 1;
end

xlabel('Energy, keV');
ylabel('N, Count');
%axis([19.5 34 0 9e6]);
legend('show');

return;




coeffs1Collect = zeros(6, 4);
coeffs2Collect = zeros(6, 3);
dpCollect = zeros(6, 1);


coeffs3Collect = zeros(6, 2);

i = 1;

index = 1;


%for e = [25 30 40 45 50 55] 
for e = [25 30 40 45 50 55] 

% [20 25:5:55]    
%for e = [40 45] 
%for e = [20 25] 
    
    ds = dataset('File',sprintf('thrafl/%d.txt', e));
    dd = double(ds);
    x = dd(:,1)';
    y = dd(:,2)';
    
    %plot(x, y, char(colors(i))); hold on;

    [coeffs1, coeffs2, dp, fittedAfl] = piecewiseFit(e, x, y);

    format long;
    disp(sprintf('%d kEv', e));
    dp
    coeffs1
    coeffs2
    
    coeffs1Collect(index, :) = coeffs1;
    coeffs2Collect(index, :) = coeffs2;
    dpCollect(index) = dp;
    
    
    if (i == 8) i = 1; end

    plot(x, fittedAfl, char(colors(i)), 'DisplayName', sprintf('fitted %d kEv', e)); hold on;
    
    
    to = (dp - x(1)) / 0.5 ;
    %if e < 30
    %    to = dp - 14.75 + 1
    %end
    
    x = x(1:to);
    y = fittedAfl(1:to);
    %plot(x, y, char(colors(i)), 'DisplayName', sprintf('fitted %d kEv', e)); hold on;
    
    
    %%%%%%%%%%%%%%%%%%%
    
    [xData, yData] = prepareCurveData( x, y );

    % Set up fittype and options.
    ft = fittype( 'exp1' );
    opts = fitoptions( ft );
    opts.Display = 'Off';
    opts.Lower = [-Inf -Inf -Inf -Inf];
    %opts.StartPoint = [0.0403613189132183 -0.0341013757747949 0 -0.0341013757747949];
    opts.Upper = [Inf Inf Inf Inf];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );    
    
    %gof
    coeffs3Collect(index, :) = coeffvalues(fitresult);
    
    %plot(fitresult, '.-b'); hold on;
    
    
    %%%%%%%%%%%%%%%%%%%
    
    
    %return;
    
    %return;
    
    index = index + 1;

    i = i + 1;

end

%[afl] = piecewiseBuild([-1.291e-6 0.0001077 -0.003527 0.05635], [0.01272 40.35 1.578], 39);
%plot(10.5:0.5:59.5, afl, '.-k', 'DisplayName', 'built 43 kEv');
% [afl] = piecewiseBuild([-2.584e-5 0.001056 -0.01638 0.1381], [0.03605 21.37 1.61]);
% plot(10.5:0.5:59.5, afl, '.-k', 'DisplayName', 'built 43 kEv');

%a*exp(b*x)

e = 27.5;
load('thrafl/model3/p1_linear.mat', 'fitresult'); p1 = feval(fitresult, e);
load('thrafl/model3/p2_linear.mat', 'fitresult'); p2 = feval(fitresult, e);
load('thrafl/model3/p3_linear.mat', 'fitresult'); p3 = feval(fitresult, e);
load('thrafl/model3/p4_linear.mat', 'fitresult'); p4 = feval(fitresult, e);

p1
p2
p3
p4

y = zeros(1, 30);
for i = 1:30
    %y(i) = a * exp(b * (14.75 + (i-1) * 0.5));
    xx = x(1) + (i - 1) * 0.5;
    y(i) = p1*power(xx, 3) + p2*power(xx, 2) + p3*power(xx, 1) + p4;
end

plot(x(1):0.5:x(1)+29 * 0.5, y, '.-b', 'DisplayName', sprintf('%d kev exp', e));


legend('show');

return;



figure(2);
plot([25 30 40 45 50 55]  , coeffs1Collect(:,1), '.-b', 'DisplayName', 'poly3 first param'); hold on;
plot([25 30 40 45 50 55] , coeffs1Collect(:,2), '.-r', 'DisplayName', 'poly3 second param'); hold on;
plot([25 30 40 45 50 55] , coeffs1Collect(:,3), '.-g', 'DisplayName', 'poly3 third param'); hold on;
plot([25 30 40 45 50 55] , coeffs1Collect(:,4), '.-y', 'DisplayName', 'poly3 fourth param'); hold on;
legend('show');

figure(3);
plot([25 30 40 45 50 55], coeffs2Collect(:,1), '.-b', 'DisplayName', 'gauss1 first param'); hold on;
plot([25 30 40 45 50 55] , coeffs2Collect(:,2), '.-r', 'DisplayName', 'gauss1 second param'); hold on;
figure(2); plot([25 30 40 45 50 55], coeffs2Collect(:,3), '.-g', 'DisplayName', 'gauss1 third param'); hold on;

% i = 1;
% y = (coeffs2Collect(:,3) ./ coeffs2Collect(:,1));
% % for e = [23 25 30 40 45 50 55]
% %     y(i) = y(i) / e;
% %     i = i + 1;
% % end
% 
% figure(2); plot([23 25 30 40 45 50 55], y, '.-g', 'DisplayName', 'gauss1 third param'); hold on;
% legend('show');

figure(3);
index = 1;
for i = 1:3
    y = zeros(60);
    for x = 1:60
        y(x) = coeffs2Collect(i,1)*exp(-((x-coeffs2Collect(i,2))/coeffs2Collect(i,3))^2);
    end
    %plot(1:60, y, char(colors(i)), 'DisplayName', sprintf('%d', 20 + (i-1) * 5)); hold on;
    %plot(1:60, y, char(colors(i)), 'DisplayName', '?'); hold on;
    plot(1:60, y, '.-b', 'DisplayName', 'asdf'); hold on;
    index = index + 1;
end
legend('show');



figure(4);
plot([23 24 25 30 40 45 50 55], dpCollect, '.-b', 'DisplayName', 'division point'); hold on;

legend('show');




