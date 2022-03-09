

% 
% global MEASUREMENT_DATA_PATH;
% 
% xs = 20:6:230;
% ys = 128-6*5:6:128+6*4;
% 
% binning = 6;
% % % 
% MU1 = zeros(size(ys, 2), size(xs, 2), 2);
% MU2 = zeros(size(ys, 2), size(xs, 2), 2);
% 
% for y = 128 % ys
%     for index = 1:size(xs, 2)
%         x = xs(index);
% 
%         region = struct();
%         region.left = x; region.right = x + binning - 1; region.top = y; region.bottom = y + binning - 1;
%         I0 = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1480, 0, region, -1);
%         D1 = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1481, 0, region, -1);
%         D2 = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1482, 0, region, -1);
%         
%         MU2(find(ys == y), find(xs == x), :) = log(I0 ./ D1) ./ 1;
%         MU1(find(ys == y), find(xs == x), :) = log(I0 ./ D2) ./ 0.5;
%         
%     end
% end
% % 
% % return;
% 
% path = 'c:/work/acquisition/optim/d';
% 
% projs = 0:0;
% proj1 = zeros(size(ys, 2), size(xs, 2), size(projs, 2));
% proj2 = zeros(size(ys, 2), size(xs, 2), size(projs, 2));
% proji = 1;
% 
% T = zeros(size(ys, 2), size(xs, 2), 2);
% 
% for proj = projs
%     
%     proj
%         
%     for y = 128 %ys
%         for index = 1:size(xs, 2)
%             x = xs(index);
% 
%             region = struct();
%             region.left = x; region.right = x + binning - 1; region.top = y; region.bottom = y + binning - 1;        
%             
%             %D1 = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1488, 0, region, -1);
%             %D2 = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1480, 0, region, -1);
%             
%             D1 = loadDepositedSpectrumOptim(path, proj, region);
%             D2 = loadDepositedSpectrumOptim(path, 1480, region);
%            
%             yi = find(ys == y);
%             xi = find(xs == x);
% 
%             A = [ MU1(yi, xi, 1) MU2(yi, xi, 1);
%                   MU1(yi, xi, 2) MU2(yi, xi, 2); ];
%             L = log(D2 ./ D1)';
%             
%             optionsSART.nonneg = true;
%             x0 = zeros(2, 1);
%             [t, info] = sart(A, L, 100, x0, optionsSART);
%             T(yi, xi, :) = t;
%         
%         
%         %return;
% 
%             %T(yi, xi, :) = inv(A) * L;
%         end
%     end
%     
%     proj1(:, :, proji) = T(:, :, 1);
%     proj2(:, :, proji) = T(:, :, 2);
%     proji = proji + 1;
%     
% end    
% 
% % 
% plot(xs, T(find(ys == y), :, 1), '.-b'); hold on;
% plot(xs, T(find(ys == y), :, 2), '.-r'); hold on;
% return;
% 
% 
% % figure(1);
% % imshow(proj1(:, :, 1),'InitialMagnification','fit');
% % figure(2);
% % imshow(proj2(:, :, 1),'InitialMagnification','fit');
% 
% return;

r = zeros(3, 2, 10);

l1 = 0.8;
l2 = 0.3;

for (i = 1:10)

    
    
    %%%%%% effective state experiment

    spectrumRange = 20:2:40;
    incident = modelSpectrum(spectrumRange, 200000, 30, 20);



    ATT1 = loadAttenuation({'al'}, 1:11);
    %mu = permute(MU2(find(ys == y), find(xs == x), :), [3 1 2]);
    mu = permute(MU2(1, 1, :), [3 1 2]);
    mu(1:4) = 3;
    ATT = [ ATT1(1, :); mu' ];

    P = incident .* prod(exp(-(ATT .* repmat([0.9; 0.0], 1, size(incident, 1)))), 1)';
    %P = poissrnd(P);

    eff_mu = zeros(2, 2);
    eff_mu(1, 1) = log(sum(incident(1:7)) / sum(P(1:7))) / 0.9;
    eff_mu(2, 1) = log(sum(incident(8:end)) / sum(P(8:end))) / 0.9;

    P = incident .* prod(exp(-(ATT .* repmat([0; 0.9], 1, size(incident, 1)))), 1)';
    eff_mu(1, 2) = log(sum(incident(1:7)) / sum(P(1:7))) / 0.9;
    eff_mu(2, 2) = log(sum(incident(8:end)) / sum(P(8:end))) / 0.9;



    P = incident .* prod(exp(-(ATT .* repmat([l1; l2], 1, size(incident, 1)))), 1)';
    P = poissrnd(P);
    %P = poissrnd(P);

    M = P';
    M(length(M)+1:100) = realmax;
    thicks = calc_thicknesses_mex(incident, M, ATT, [7], []);
    
    r(1, 1, i) = thicks(1);
    r(1, 2, i) = thicks(2);

    L = [ log( sum(incident(1:7)) / sum(P(1:7)) ); log( sum(incident(8:end)) / sum(P(8:end)) ) ];

    T = inv(eff_mu) * L;
    
    r(2, 1, i) = T(1);
    r(2, 2, i) = T(2);

    %%% super effective mu
    %     mu1 = prod(exp(-(ATT(1, :) .* repmat([0], 1, size(incident, 1)))), 1)';
    %     mu2 = prod(exp(-(ATT(2, :) .* repmat([0.3], 1, size(incident, 1)))), 1)';
    % 
         eff_mu = [ sum(ATT(1, 1:7)' .* incident(1:7) / sum(incident(1:7)))  sum(ATT(1, 8:end)' .* incident(8:end) / sum(incident(8:end)));
                 sum(ATT(2, 1:7)' .* incident(1:7) / sum(incident(1:7)))  sum(ATT(2, 8:end)' .* incident(8:end) / sum(incident(8:end))); ];
    %     eff_mu = [ sum(mu1(1:7) .* incident(1:7) / sum(incident(1:7)))  sum(mu2(1:7) .* incident(1:7) / sum(incident(1:7)));
    %             sum(mu1(8:end) .* incident(8:end) / sum(incident(8:end)))  sum(mu2(8:end) .* incident(8:end) / sum(incident(8:end))); ];
    %             



        %

        T = inv(eff_mu) * L;
        
        r(3, 1, i) = T(1);
        r(3, 2, i) = T(2);        

%plot(spectrumRange, incident, '.-b');

end


% plot(1:10, permute(r(1, 1, :), [3 1 2]), '.-b'); hold on;
% plot(1:10, permute(r(1, 2, :), [3 1 2]), '.-r'); hold on;

figure(3);
plot(1:10, permute(r(1, 1, :), [3 1 2]), '.-k', 'DisplayName', 'Aluminium (Spectrum based)'); hold on;
plot(1:10, permute(r(1, 2, :), [3 1 2]), '.-g', 'DisplayName', 'Iodine (Spectrum based)'); hold on;

plot(1:10, permute(r(2, 1, :), [3 1 2]), '.-b', 'DisplayName', 'Aluminium (Effective mu)'); hold on;
plot(1:10, permute(r(2, 2, :), [3 1 2]), '.-r', 'DisplayName', 'Iodine (Effective mu)'); hold on;

legend('show');
title('Comparison of spectral methods on 0.8 al, 0.3 iodine spectral modeling');
 