

global MEASUREMENT_DATA_PATH;


[Rij, photonsCount, photonRate] = genAFLFromReflexOptim(20:2:40, ...
    path, ...
    480, ...
    0);

global colors;
colorIndex = 1;

%region.left = 50; region.right = 220; region.top = 50; region.bottom = 220;
%region.left = 100; region.right = 100; region.top = 100; region.bottom = 100;

figure(1);

xs = 20:6:230;
ys = 128-6*5:6:128+6*4;

% xs = 20+6*0;
%ys = 128 -6*5;

%xs = 133;

al = zeros(size(xs));
iodine = zeros(size(xs));
index = 1;


ATT1 = loadAttenuation({'al'}, 1:11);

%[inc1] = energy_recon_func(Rij, 1440, region);

%MU=zeros(size(ys, 2), size(xs, 2), 11);
%INC = zeros(size(ys, 2), size(xs, 2), 11);

tic

if isempty(gcp('nocreate')), parpool; end


binning = 6;

measurement_data_path = MEASUREMENT_DATA_PATH;
%measurement_data_path = '//192.168.0.105/work/politeh/pixet_spectral';

projs = 0:0;
proj1 = zeros(size(ys, 2), size(xs, 2), size(projs, 2));
proj2 = zeros(size(ys, 2), size(xs, 2), size(projs, 2));
proji = 1;

for proj = projs
 
    %inc = permute(INC(1, find(xs == 20+6*20), :), [3 1 2]);

    for y = 128+6*4 %ys %128
        for index = 1:size(xs, 2)


            x = xs(index);

            %x
            %y

            region = struct();

            region.left = x; region.right = x + binning - 1; region.top = y; region.bottom = y + binning - 1;
            %region.left = 50; region.right = 220; region.top = 50; region.bottom = 220;
    % 
                [inc] = energy_recon_func(Rij, 1490, region);
                %[measure] = energy_recon_func(Rij, 1491, region);
%                        plot(1:size(inc, 1), inc, '.-r'); hold on;
%                        plot(1:size(inc, 1), measure, '.-b'); hold on;
%         % %             
%                       return;               

    %           [inc] = energy_recon_func(Rij, 1466, region);
    %           [measure] = energy_recon_func(Rij, 1467, region);
    %     %      
%             mu = log(inc ./ measure) ./ 0.41;
%             mu(isnan(mu)) = realmax;
%             mu(isinf(mu)) = realmax;
%             mu(isnan(mu)) = realmax;
%             mu(isinf(mu)) = realmax;      
% 
                mu = permute(MU2(find(ys == y), find(xs == x), :), [3 1 2]);
                %inc = permute(INC(find(ys == y), find(xs == x), :), [3 1 2]);
% 
%              MU(find(ys == y), find(xs == x), :) = mu;
%              %INC(find(ys == y), find(xs == x), :) = energy_recon_func(Rij, 1440, region); 
%              continue;
        %  

                %D = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, 1468, 0, region, -1);
                %inc = energy_recon_func(Rij, 1440, region); 
                %INC(find(ys == y), find(xs == x), :) = inc;
                %[measure] = energy_recon_func(Rij, 1468, region); 
        % % %      

        %     

        %     return;
        %     
        %     
        %         figure(6);
        %               plot(1:size(inc, 1), inc, '.-r'); hold on;
        %               plot(1:size(inc, 1), measure, '.-b'); hold on;
        % %             
                      %return;
        % % % % % % %       
        % % % % % % 
        %        plot(1:size(inc, 1), inc .* exp(-ATT1(1, :)' * 0.4660) .* exp(-mu * 0.016), '.-g'); hold on;
        %         plot(1:size(inc, 1), inc .* exp(-ATT1(1, :)' * 0.4850) .* exp(-mu * 0), '.-k'); hold on;
        % %      
        %      attenuated = inc .* exp(-ATT1(1, :)' * 0.75) .* exp(-mu * 0);
        %      diff1 = (measure - attenuated);
        %      plot(1:size(diff1, 1), diff1, '.-b'); hold on;
        % 
        %      attenuated = inc .* exp(-ATT1(1, :)' * 0.6380) .* exp(-mu * 0.1380);
        %      diff1 = (measure - attenuated);
        %      plot(1:size(diff1, 1), diff1, '.-r'); hold on;     


        %     
        %      %plot(1:size(inc, 1), inc .* exp(-mu2 * 0.85) .* exp(-mu * 0.00), '.-g'); hold on;


        %     colorIndex = 1;
        %     plot(1:size(inc, 1), inc, char(colors(colorIndex)), 'DisplayName', sprintf('%d', x)); hold on;
        %     colorIndex = colorIndex + 1;
        %     if (colorIndex == 8)
        %         colorIndex = 1;
        %     end
        %     %axis([1 size(inc, 1) 0 20e4]);
        %      print(sprintf('spectral/pics/%04d', x), '-dpng');
        %      close all;

             %continue;


        %     mu2 = log(inc ./ measure) ./ 1;
        %     mu2(isnan(mu2)) = realmax;
        %     mu2(isinf(mu2)) = realmax;
        %     mu2(isnan(mu2)) = realmax;
        %     mu2(isinf(mu2)) = realmax;
        %     
        %     
        %     return;
            %mu(3) = realmax;


            %ATT = [ mu1'; mu' ];
            %ATT = [ mu2'; mu'  ];
            ATT = [ ATT1(1, :); mu'  ];


            D = loadDepositedSpectrum(measurement_data_path, 1491, 0, region, -1);
            %D = D .* 2;
            
            %D = measure';

            %return;

            %[measure] = energy_recon_func(Rij, 1457, region); 

            %[7 10]
            
            M = D;
            M(length(M)+1:100) = realmax;
            thicks = calc_thicknesses_mex(inc, M, ATT, [10], [Rij]);

            al(index) = thicks(1);
            iodine(index) = thicks(2);
            %index = index + 1;

        end

        proj1(find(ys == y), :, proji) = al;
        proj2(find(ys == y), :, proji) = iodine;
    end
    
    proji = proji + 1;

    toc

    %return;
%     figure(1);

    plot(xs, al, '.-b', 'DisplayName', 'Al'); hold on;
    plot(xs, iodine, '.-r', 'DisplayName', 'Iodine'); hold on;
%     
%     title(sprintf('Al/Iodine decomposed thicknesses\nMethod: Incident detected based\nData type using on decomposion: spectrum \n Noise/Material Correlation lvl %.3f%% ', sum(iodine(6:11)) / sum(al(6:11))));
%     xlabel('Projection Row Slice, px');
%     ylabel('Thickness, cm');
%     legend('show');
%     
%     print('spectral/pics/decomp_incbased_spectrum', '-dpng');
    
    
    
%     figure(1);
%     imshow(proj1,'InitialMagnification','fit');
%     figure(2);
%     imshow(proj2,'InitialMagnification','fit');
    
end   

% figure(1);
% imshow(proj1(:, :, 5),'InitialMagnification','fit');
% figure(2);
% imshow(proj2(:, :, 5),'InitialMagnification','fit');


%legend('show');
    

return;
% % 
% [measure] = energy_recon_func(Rij, 1242, region);
% % % 
% %     
% % mu2 = log(inc ./ measure) ./ 1;
% % mu2(isnan(mu)) = realmax;
% % mu2(isinf(mu)) = realmax;
% %  mu2(isnan(mu2)) = realmax;
% %  mu2(isinf(mu2)) = realmax;
% %  mu2(3) = realmax;
% % 
% % 
% mu = log(inc ./ measure) ./ 1;
% mu(isnan(mu)) = realmax;
% mu(isinf(mu)) = realmax;
% mu(isnan(mu)) = realmax;
% mu(isinf(mu)) = realmax;
% mu(3) = realmax;

%return;


%ATT = [ ATT1(1, :); mu';];

%ATT = [ ATT1(1, :); ];

%   plot(1:size(inc, 1), inc, '.-r'); hold on;
%   plot(1:size(measure, 1), measure, '.-b'); hold on;
%   
% return;  

% 
% plot(1:size(mu1, 1), mu1, '.-r'); hold on;
% plot(1:size(mu2, 1), mu2, '.-b'); hold on;
% 
 %return;

%%% 1040 - inc, 1041 - 1.88 al, 1042 - 3.45 al, 1043 - 5.01 al, 1044 - 0.32 cu

%region.left = 100; region.right = 100; region.top = 100; region.bottom = 100;
% region.left = 50; region.right = 150; region.top = 50; region.bottom = 150;
f = (region.right - region.left + 1) * (region.bottom - region.top + 1);
% [inc] = energy_recon_func(Rij, 1040, region);
% %inc = inc ./ (region.right - region.left + 1) * (region.bottom - region.top + 1);
% %spectrum = inc;
% %save('recon_inc', 'spectrum');
% pixel_inc = 0;
% 


%xs = 50;


iodine = zeros(size(xs));
al = zeros(size(xs));

index = 1;

for x = xs
    
%ys = 20:9:230;
y = 100;



    %x = 40;
    %y = 200;
    
    
    binning = 20;

    %region.left = x; region.right = x + binning - 1; region.top = y; region.bottom = y + binning - 1;
    
    region.left = 50; region.right = 220; region.top = 50; region.bottom = 220;
    [inc] = energy_recon_func(Rij, 1440, region);     
    %save('recon_measure', 'spectrum');
    [measure] = energy_recon_func(Rij, 1441, region);     
    %save('recon_measure', 'spectrum');

    
    %measure = measure * f / 81;
    %measure = [measure zeros(1, size(Rij, 1) - size(measure, 2)) ];
    
    
   
    %[measure] = energy_recon_func(Rij, 1045, region);
    % 
    % %plot(spectrumRange, inc .* exp(-0.188 * ATT(1, :))', '.-b'); hold on;
    % 
    %inc = inc .* exp(-0.188 * ATT(1, :) * 0.032 .* ATT(2, :))';
    %inc = inc .* exp(-1 * ATT(2, :))';
    %inc = inc .* exp(-0.188 * ATT(1, :))';
    % % % 
     %mde = inc' * Rij';

    % [measure] = energy_recon_func(Rij, 1142, region);
    %measure = measure * f / 81;

    % spectrum = measure;
    % save('recon_measure', 'spectrum');
    % return;
    % 
    % % 
    % %plot(1:size(inc, 1), inc, '.-r'); hold on;
    % 
     plot(1:size(inc, 1), inc, '.-r'); hold on;
     plot(1:size(measure, 1), measure, '.-b'); hold on;
     
     return;

    %region.left = 20; region.right = 256 - 20; region.top = 20; region.bottom = 256 - 20;
    %spectrum = spectrum * (region.right - region.left + 1) * (region.bottom - region.top + 1) / 2;

    %measure = measure * (region.right - region.left + 1) * (region.bottom - region.top + 1) / (217 * 217);
    
    %save('recon_measure', 'spectrum');


    % [measure] = energy_recon_func(Rij, 1141, region);
    %

    %figure(3);

    %inc = inc .* exp(-0.2025 * ATT1(1, :))';
    %inc = inc .* exp(-0.2510 * ATT(1, :))';
    %inc = inc .* exp(-1. * ATT(2, :))';
    %inc = inc .* exp(-1.1570 * ATT(2, :))';
    


    %binBorder = 8;
    %M = measure;
    %XBINS = ([sum(M(1:binBorder(1)), 2); sum(M(binBorder(1)+1:size(M, 1)), 1); ]) 

    %return;    



    %figure(1);
%     plot(1:size(inc, 1), inc, '.-r'); hold on;
%     plot(1:size(measure, 1), measure, '.-b'); hold on;
%     
%       plot(1:size(mde, 2), mde, '.-r'); hold on;
%       plot(1:size(mde, 2), measure, '.-b'); hold on;
%       return;

    %return;

    %inc = inc .* exp(-0.2025 * ATT1(1, :))';
    %plot(1:size(measure, 1), inc .* exp(-1 * ATT(1, :))', '.-r'); hold on;
    % 
    % mu = log(inc ./ measure) ./ 1;
    % mu(isnan(mu)) = realmax;
    % mu(isinf(mu)) = realmax;

    thicks = calc_thicknesses(inc, measure, ATT);
    
    
    %fprintf('%d %d %.4f %.4f\n', x, y, thicks(1), thicks(2));
    
    %inc_ = inc .* exp(-thicks(2) * ATT(2, :))';
    %inc_ = inc .* exp(-thicks(1) * ATT(1, :))';
    
%     mde = inc_' * Rij';
%      plot(1:size(inc, 1), inc, '.-r'); hold on;
%      plot(1:size(measure, 1), measure, '.-b'); hold on;
%     return;
        
    
%      plot(1:size(mde, 2), mde, '.-r'); hold on;
%      plot(1:size(mde, 2), measure, '.-b'); hold on;
%         print(sprintf('spectral/pics/%04d_%04d', index, x), '-dpng');
%         close all;
    %return;
    
    al(index) = thicks(1);
    %iodine(index) = thicks(2);
    
    index = index + 1;
    


end

plot(xs, al(1:size(xs, 2)), '.-b'); hold on;
%plot(xs, iodine(1:size(xs, 2)), '.-r'); hold on;
%print(sprintf('spectral/pics/%04d', x), '-dpng');
%close all;

return;

per = 0;
index = 1;
for x = xs
    per = per + abs(al(index) - 0.188) / 0.188 + abs(iodine(index) - 1) / 1;
end
per = per / size(xs, 2) / 2;
per

return;



spectrumRange = 20:2:20 + 2 * (size(Rij, 2)-1);

summper = 0;

% [measure] = energy_recon_func(Rij, 1041, region);
% mu = log(inc ./ measure) ./ 0.188;
% mu(isnan(mu)) = realmin;
% mu(isinf(mu)) = realmin
% ATT = mu';


experiments = 1142;
for experiment = experiments
    normFactor = 1;
    etalonLI = 0;
    
    switch experiment
        case 1041
            ATT = loadAttenuation({'al'}, 1:13);
            etalonLI = 0.188;
        case 1042
            ATT = loadAttenuation({'al'}, 1:13);
            etalonLI = 0.345;
        case 1043
            ATT = loadAttenuation({'al'}, 1:13);
            etalonLI = 0.501;  
            normFactor = 5;
        case 1044
            ATT = loadAttenuation({'cu'}, 1:13);
            etalonLI = 0.032;            
            normFactor = 5 / 3;
            
        case 1051
            ATT = loadAttenuation({'al'}, 1:13);
            etalonLI = 0.188;            
            normFactor = 5;     
            
        case 1052
            ATT = loadAttenuation({'al'}, 1:13);
            etalonLI = 0.345;            
            normFactor = 5 / 2;
            
                    
            
    end
        
    [measure] = energy_recon_func(Rij, experiment, region, normFactor);
    
%     plot(spectrumRange, inc .* exp(-etalonLI * ATT(1, :))', '.-b'); hold on;
%     plot(spectrumRange, measure, '.-r'); hold on;
%     return

    per = (calc_thicknesses(inc, measure, ATT) - etalonLI) / etalonLI;
    summper = summper + per;
    
    %calc_linear_integrals(inc, measure, ATT)
    
    fprintf('%d %.4f %%\n', experiment, (calc_thicknesses(inc, measure, ATT) - etalonLI) / etalonLI);
    
end    

fprintf('average per %.4f %%\n', summper / size(experiments, 2));
    




%thickness1


