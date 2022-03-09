
figure(1);

colors = {'.-b' '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };
colorIndex = 1;

%%% ---- Initialization ----

numberOfIncidentBins = 13;
numberOfDetectedBins = 2;
n = numberOfDetectedBins;
%%% TODO: handle binBorder with elements more than one

for binBorder = 8:8 



% space1 = 0:0.002:0.3;
% space2 = 0.00:0.0002:0.04;
space1 = 0:0.001:0.25;
space2 = 0.0:0.001:1.5;

% space1 = 0.97;
% space2 = 0.188;

numberOfMaterials = 2;

%%% ---- ---- Initialization att coeffs ----

% ATT = zeros(numberOfMaterials, numberOfIncidentBins);
% 
% ATT(1, :) = [ 4.08700 0.896800 ];
% ATT(2, :) = [ 133.711 19.7656 ];
%ATT = loadAttenuation({'al', 'cu'}, 1:13);
%ATT = loadAttenuation({'ki', 'al'}, 1:33);
% 
 %ATT = [ ATT(:, 14:21) ATT(:, 24:29) ];


%                 NLAMBDAl = N0l_ * exp(-4.08700 * t1) * exp(-133.711 * t2);
%                 NLAMBDAh = N0h_ * exp(-0.896800 * t1) * exp(-19.7656 * t2);

%ATT = [ 4.08700 0.896800; 133.711 19.7656 ];

%%% ---- ---- Load/Initizalization input (different variants) ----

% X = [0.188; 0.033];
% 
% XBINS = zeros(numberOfDetectedBins, 1);
% INC = zeros(numberOfIncidentBins, 1);

    %%% ---- 
    load('recon_inc');
    INC = spectrum;
    
    load('recon_measure');
    X = spectrum;
    
%     INC =  [ INC(14:21); INC(24:29) ];
%     X =  [ X(14:21); X(24:29) ];
    
%     plot(1:44, INC, '.-b'); hold on;
%     plot(1:44, X, '.-b'); hold on;
%     return;
    
    
    prop1 = 0.9718;
    
%     bin1 = 25;
%     bin2 = 33;    
    
%     A = [ATT(1, bin1) * prop1 + ATT(2, bin1) * (1 - prop1)  ATT(3, bin1) ; 
%          ATT(1, bin2) * prop1 + ATT(2, bin2) * (1 - prop1) ATT(3, bin2) ; 
%          ];
%     L = [log(INC(bin1)/X(bin1)); 
%          log(INC(bin2)/X(bin2))  ];
%     
%     W = inv(A) * L
%     
%     v = zeros(1, 1);
%     i = 1;
%     
%     W = zeros(2, 1);
%     for bin1 = 15:28
%     %bin2 = 25;
%         A = [ATT(1, bin1) ATT(2, bin1) ; 1 1 ];
%         L = [log(INC(bin1)/X(bin1)); 0.222  ];
% 
%         INC(bin1)
%         X(bin1)
%         
%         W = inv(A) * L;
%         
%         v(i) = W(2);
%         i = i + 1;
%         
%         %inv(A) * L
% 
%         %W = W + inv(A) * L;
%     end
%     
%     plot(1:i-1, v);
%     
%     %W / 14
% 
%     return;
%     
%     v = zeros(1, 1);
%     i = 1;
% % 
%     for bin1 = 15:30
%         for bin2 = bin1+1:31
%             if (bin1 == bin2) continue; end
% %             A = [ATT(1, bin1) ATT(2, bin1) ; ATT(1, bin2) ATT(2, bin2) ];
% %             L = [log(INC(bin1)/X(bin1)); log(INC(bin2)/X(bin2))  ];
% %             
%     A = [ATT(1, bin1) * prop1 + ATT(2, bin1) * (1 - prop1)  ATT(3, bin1) ; 
%          ATT(1, bin2) * prop1 + ATT(2, bin2) * (1 - prop1) ATT(3, bin2) ; 
%          ];            
%      
%      L = [log(INC(bin1)/X(bin1)); 
%           log(INC(bin2)/X(bin2))  ];     
%             
%             W = inv(A) * L
%             
%             %v(i) = W(1);
%             %i = i + 1;
%         end
%     end
%     
%     size(v)
%     plot(1:i-1, v);
%     
%     
     %return;

    
%     ds = dataset('File','c:/work/acquisition/spectrometer/difraction/minc.asc');
%     dd = double(ds);
%     x = dd(:, 1);
%     y = dd(:, 2);
%     INC = [ sum(y(find(x == 1564):find(x == 1996))); sum(y(find(x == 2720):find(x == 3775))) ];
%     ds = dataset('File','c:/work/acquisition/spectrometer/difraction/mmeasure.asc');
%     dd = double(ds);
%     x = dd(:, 1);
%     y = dd(:, 2);
%     X = [ sum(y(find(x == 1564):find(x == 1996))); sum(y(find(x == 2720):find(x == 3775))) ];
%     
% %     A = [4.07087 133.160; 0.881938 19.2025; 1 1];
% %     L = [log(INC(1)/X(1)); log(INC(2)/X(2)); 0.222 ];
% 
% %     A = [4.07087 133.160; 1 1];
% %     L = [log(INC(1)/X(1)); 0.222 ];
%     
%     A = [0.881938 19.2025; 1 1];
%     L = [log(INC(2)/X(2)); 0.222 ];
%       
%     INC
%     X
% 
%     W = inv(A) * L
% 
%     return;
    
    XBINS = ([sum(X(1:binBorder(1)), 1); sum(X(binBorder(1)+1:size(X, 1)), 1); ])
    
    %XBINS
%     
%     INC = modelSpectrum(19:40, 10000, 30, 20);
%     ATTEDINC = (INC) .* prod(exp(-(ATT .* repmat(X, 1, 22))), 1)';
%     XBINS = ([sum(ATTEDINC(1:binBorder(1)), 1); sum(ATTEDINC(binBorder(1)+1:size(ATTEDINC, 1)), 1); ]);        
%     
%     INC = [ 412376 ;10768  ]  ;
%     ATTEDINC = INC .* prod(exp(-(ATT .* repmat(X, 1, 2))), 1)';
%     XBINS = poissrnd([sum(ATTEDINC(1:binBorder(1)), 1); sum(ATTEDINC(binBorder(1)+1:size(ATTEDINC, 1)), 1); ]);        
    
%     XBINS = [2385; 4795];
    
    
%     ds = dataset('File','spectral/spectrometer/1.0.txt');
%     dd = double(ds);
%     x = dd(:, 1);
%     y = dd(:, 2);
% 
%     %plot(x, y, '.-b');
%     %return;
% 
%     N0l = sum(y(find(x == 25.81):find(x == 28.44)));
%     N0h = sum(y(find(x == 52.2):find(x == 54.37)));
% 
%     ds = dataset('File','spectral/spectrometer/experiment/1.0.txt');
%     dd = double(ds);
%     x = dd(:, 1);
%     y = dd(:, 2);
%     Nl = sum(y(find(x == 25.81):find(x == 28.44)));
%     Nh = sum(y(find(x == 52.2):find(x == 54.37)));
%     
%     INC(1) = N0l;
%     INC(2) = N0h;
%     
%     XBINS(1) = Nl;
%     XBINS(2) = Nh;


%%% ---- SLAU fast calc ----
% M = [ 4.08700 133.711; 0.896800 19.7656; ];
% L = [ log(N0l / Nl); log(N0h / Nh) ];
% 
% Q = inv(M) * L


%%% 




%%% ---- Build thickness space ----

[x, y] = meshgrid(space1, space2);
cond = NaN(size(x));
C = NaN(size(x));

t1best = 0;
t2best = 0;
minz = realmax;

t1min = realmax;
t1max = realmin;
t2min = realmax;
t2max = realmin;

variantsExist = 0;

totalThickness = 0.188 + 0.032;



v = zeros(1);



i1 = 1;
for t1 = space1
%for t1 = 0.1:0.0001:totalThickness
    
    %t1
    
    i2 = 1;
    
    for t2 = space2
    %t2 = totalThickness - t1;
            
        %LAMBDA = INC .* prod(exp(-(ATT .* repmat([t1 * prop1; t1 * (1 - prop1); t2], 1, size(INC, 1)))), 1)';

        
        LAMBDA = INC .* prod(exp(-(ATT .* repmat([t1; t2], 1, size(INC, 1)))), 1)';
        
 
%         attenuation = exp(- 0.0481 .* ATT(1, :))';
%         attenuation = attenuation .* exp(-0.2030 .* ATT(2, :))';     
%         
%         LAMBDA2 = INC .* attenuation;
% %         
%          %plot(1:33, LAMBDA, '.-b'); hold on;
%          plot(1:14, LAMBDA2, '.-r'); hold on;
%          plot(1:14, X, '.-k'); hold on;
%          return;

       
        LAMBDABINS = [sum(LAMBDA(1:binBorder(1)), 1); sum(LAMBDA(binBorder(1)+1:size(LAMBDA, 1)), 1); ];
        


        z = 0;
        for b=1:n
            z = z + power(XBINS(b) - LAMBDABINS(b), 2) / LAMBDABINS(b);
        end
        z = z / n;
        z = power(z, 0.5);
        
%         C(i2, i1, 1) = 1;
%         C(i2, i1, 2) = 1;
%         C(i2, i1, 3) = 1;       

        v(i1) = z;
        
%         if (z < minz)
%             minz = z;
%             t1best = t1;
%             t2best = t2;
%         end
        
        if (z < 30)
             cond(i2, i1) = 1;
%             
             C(i2, i1, 1) = 0;
             C(i2, i1, 2) = 0;
             C(i2, i1, 3) = 1;

            
            if (z < minz)
                minz = z;
                t1best = t1;
                t2best = t2;
            end
            

            
%             if (t1 < t1min)
%                 t1min = t1;
%             end
%             if (t1 > t1max)
%                 t1max = t1;
%             end
%             if (t2 < t2min)
%                 t2min = t2;
%             end
%             if (t2 > t2max)
%                 t2max = t2;
%             end
%             
%             variantsExist = 1;
            
        end
        
               
        i2 = i2 + 1;

    end
    
    i1 = i1 + 1;
end


%%% ---- Output ----

t1best
t2best
minz

t1best - 0.0528
t2best - 0.1909

(t1best - 0.0528) / 0.0528
(t2best - 0.1909) / 0.1909

surf(x, y, cond, C); hold on;
view(0,90);

%axis([ space1(1) space1(length(space1)) space2(1) space2(length(space2)) ]);
axis([ x(1,1) x(1, size(x, 2)) y(1,1) y(size(y, 1), 1) ]);

%plot(0.1:0.0001:totalThickness, v, '.-b');
return;

x_ = x;
for i = 1:size(x, 1)
    for j = 1:size(x, 2)
        x_(i, j) = (x(i, j) - 0.0528) / 0.0528;
    end
    
end

y_ = y;
for i = 1:size(x, 1)
    for j = 1:size(x, 2)
        y_(i, j) = (y(i, j) - 0.1909) / 0.1909;
    end
    
end

surf(x_, y_, cond, C); hold on;
view(0,90);

%axis([ space1(1) space1(length(space1)) space2(1) space2(length(space2)) ]);
axis([ x_(1,1) x_(1, length(x_)) y_(1,1) y_(size(y, 1), 1) ]);

%axis([0.15 0.3 0 0.02]);


%print(sprintf('spectral/spaces/z-1-border_%d', binBorder), '-dpng');

return;


if variantsExist == 0
    fprintf('border no variants\n');    
else
    fprintf('border %d t1best %.3f t2best %.3f z-scope %.2f (%.3f %.3f)\n', binBorder, t1best, t2best, minz, t1min + (t1max - t1min) / 2, t2min + (t2max - t2min) / 2);
end

close all;

end

