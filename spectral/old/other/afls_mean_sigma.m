

%figure(2);

close all;

% i = 1;
% sigmaX(i) = 19;
% sigmaY(i) = 115;
% i = i + 1;
% sigmaX(i) = 21;
% sigmaY(i) = 126;
% i = i + 1;
% 
% sigmaX(i) = 23;
% sigmaY(i) = 133;
% i = i + 1;
% sigmaX(i) = 25;
% sigmaY(i) = 143
% i = i + 1;
% sigmaX(i) = 29;
% sigmaY(i) = 156;
% i = i + 1;
% sigmaX(i) = 41;
% sigmaY(i) = 189;
% i = i + 1;
% sigmaX(i) = 49;
% sigmaY(i) = 207;
% i = i + 1;
% sigmaX(i) = 55;
% sigmaY(i) = 227;
% i = i + 1;
% 
% 
% 
% plot(sigmaX, sigmaY, '.-b');
% 
% return;




i = 1;
j = 1;

% sigmaX(i) = toenergy(37);
% sigmaY(i) = 1.081;
% i = i + 1;
% sigmaX(i) = toenergy(42);
% sigmaY(i) = 25.17;
% i = i + 1;
% sigmaX(i) = toenergy(42);
% sigmaY(i) = 25.17;
% i = i + 1;

% meanX(j) = toenergy(37);
% meanY(j) = 23.26;
% j = j + 1;
% meanX(j) = toenergy(42);
% meanY(j) = 32.85;
% j = j + 1;
% % full manual
% meanX(j) = toenergy(47);
% meanY(j) = 42;
% j = j + 1;
% meanX(j) = toenergy(52);
% meanY(j) = 50;
% j = j + 1;
% meanX(j) = toenergy(57);
% meanY(j) = 57;
% j = j + 1;
% meanX(j) = toenergy(57);
% meanY(j) = 57;
% j = j + 1;
% meanX(j) = toenergy(62);
% meanY(j) = 62;
% j = j + 1;
% meanX(j) = toenergy(67);
% meanY(j) = 69;
% j = j + 1;
% meanX(j) = toenergy(72);
% meanY(j) = 75;
% j = j + 1;
% meanX(j) = toenergy(77);
% meanY(j) = 79;
% j = j + 1;
% meanX(j) = toenergy(82);
% meanY(j) = 86;
% j = j + 1;
% meanX(j) = toenergy(92);
% meanY(j) = 94;
% j = j + 1;
% meanX(j) = toenergy(107);
% meanY(j) = 106;
% j = j + 1;
% meanX(j) = toenergy(122);
% meanY(j) = 120;
% j = j + 1;


%  h = plot( meanX, meanY, '.-b' ); hold on;
%  axis( [ 1, 200, 0, 200 ] );
% 
%  return;

number = 0;

fileIDSigma = fopen('sigma.txt','w');
fprintf(fileIDSigma, 'x y\n');

for tot = 19:2:53
    
    if tot == 39
        continue;
    end
    
%     if (number == 10) 
%         break;
%     end
    
    ds = dataset('File',sprintf('stats/thl5/txt/e_mirror%d.txt', tot));
    dd = double(ds);
    x = dd(:,1);
    y = dd(:,2);
    
   
    %return;
    
%      fig = figure( 'Name', 'untitled fit 1' );
%      set(fig,'position',[-1280 + mod(10 + number * 638, int32(3200)), 100 + idivide(number, int32(5)) * 500, 600, 400]);

%      tot
    
    [fitresult, gof] = createFit(x, y, tot);
    coeffs = coeffvalues(fitresult);
    
    sigmaX(i) = tot;
    sigmaY(i) = coeffs(3);
    i = i + 1;
    
    fprintf(fileIDSigma, '%d %.2f\n', tot, coeffs(3) / 10);
    
    meanX(j) = toenergy(tot);
    meanY(j) = coeffs(2);
    j = j + 1;

%     h = plot( x, y, '.-b' ); hold on;
%     h = plot( fitresult, '.-r' ); hold on;
%     
%     axis( [ 1, 1200, 0, 300 ] );
%     str = sprintf('TOT - %d %.2f kEv rsquare %.2f mean %.2f sigma %.2f', tot, toenergy(tot), gof.rsquare, coeffs(2), coeffs(3) )
%     title(str);
%     legend( 'mirrored afl', 'gauss1' );
%     xlabel( 'x' );
%     ylabel( 'y' );
%     grid on   
%     
   number = number + 1;
    
end

fclose(fileIDSigma);

%return;

 h = plot( sigmaX, sigmaY, '.-b' ); hold on;
 axis( [ 1, 60, 0, 200 ] );
%  h = plot( meanX, meanY, '.-b' ); hold on;
%  axis( [ 1, 200, 0, 200 ] );




return;
