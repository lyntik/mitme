
global gyyy;
global MDE;
gyyy = 0;

figure(2);

path = '//192.168.0.105/work/politeh/thrscan/bias200clock16';
%path = 'c:/work/acquisition/orig/bias200clock16';

colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };
colorIndex = 1;

ATT = loadAttenuation({'cu'}, 1:13);
%ATT = loadAttenuation({'al2'}, 1:31);

deposOffset = 0;
deposIterationsTo = -1;

resultFactor = 1;
% 
% % 
%[Rij, photonsCount, photonRate] = genAFLFromReflex(20:2:50, ...
%         path, ...
%         150, 225, ...
%         0, ...
%         480, ...
%         0, ...
%         1, ...
%         false); 

%Rij = RijOld;




spectrumRange = 20:2:20 + 2 * (size(Rij, 2)-1);
%spectrumRange = [ 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 ];
depositionRange = 16:2:16 + 2*(size(Rij, 1)-1);


spectrum_stripping = 0;
matlab_optimizer = 0;
sart_recon = 1;
mlem_itr_recon = 0;

iterationsNumber = 10000;

comparison = 1;

code = 1040;

show_recon = 1; % 1: show recon, 0: show forward

n = size(spectrumRange, 2)
dn = size(depositionRange, 2)


prop1 = 0.9718;


thr = 0;

model = 0;
    inaccurate_response = 0 % if model
    inaccurate_percent = 5
    
step = 1;    
    
to = 1;
if (comparison == 1)
    to = 2;
end

for experiment = 1:to
    
    att = ATT(1, :);
    %experiment settings
    
    normFactor = 1;
    
    incBins = size(spectrumRange, 2);
    attenuation = ones(incBins, 1);
    
    if (experiment == 1)
        spectrumFile = '1005.txt';
        experimentCode = code;
        % 1000
        %region.left = 160; region.right = 200; region.top = 120; region.bottom = 180;
        % 1001
        %region.left = 50; region.right = 200; region.top = 20; region.bottom = 130;
        
        % 1013 clean
        %region.left = 50; region.right = 110; region.top = 20; region.bottom = 130;
        % 1014 ki (waterless)
        %region.left = 175; region.right = 230; region.top = 20; region.bottom = 130;
        % 1015 al 1.88, 1016 cu 0.32, 1017 al 3.425
        %region.left = 170; region.right = 220; region.top = 20; region.bottom = 120;        
        
        % 1018 h2oki, 1019 clean
        %region.left = 30; region.right = 220; region.top = 20; region.bottom = 160;        
        
        % 1030 al 1.88
        %region.left = 140; region.right = 230; region.top = 20; region.bottom = 130;
        
        % 10xx set 5
        %region.left = 20; region.right = 256 - 20; region.top = 20; region.bottom = 256 - 20;
        
        % 11xx
        %experimentCode = 1150;
        %region.left = 140; region.right = 230; region.top = 50; region.bottom = 200;
        
        region.left = 20; region.right = 256 - 20; region.top = 20; region.bottom = 256 - 20;
        
        
        %region.left = 140; region.right = 240; region.top = 20; region.bottom = 100;
        
        
        
        
        color = '.-r';
%        color = char(colors(colorIndex));
%         colorIndex = colorIndex + 1;
%         if (colorIndex == 8) 
%             colorIndex = 1; 
%         end
%         
%         color
%         colorIndex
        
        %attenuation = exp(-0.191 .* ATT(1, :))' .* exp(-0.033 * ATT(2, :))';
        %attenuation = exp(-0.97 .* ATT(1, :))';
        %d = 1.05;
        d = 0.97;
        
        %
        %attenuation = exp(-prop1 * d .* ATT(1, :))' .* exp(-(1 - prop1) * 0.5 * d * ATT(2, :))' .* exp(-(1 - prop1) * 0.5 * d * ATT(3, :))';
        %attenuation = attenuation .* exp(-0.188 .* ATT(4, :))';
        
        %attenuation = exp(-prop1 * d .* ATT(1, :))' .* exp(-(1 - prop1) * d * ATT(2, :))';
        %attenuation = attenuation .* exp(- 0.188 .* ATT(3, :))';
 
        %attenuation = exp(- 0.0528 .* ATT(1, :))'; % ki
        %attenuation = exp(- 0.0198 .* ATT(1, :))'; % ag
        %attenuation = attenuation .* exp(-0.3425 .* ATT(2, :))'; % al 3.4
        %attenuation = attenuation .* exp(-0.1909 .* ATT(2, :))'; % al 1.9
        %attenuation = attenuation .* exp(-0.0336 .* ATT(3, :))'; % cu 0.33
        
        if (comparison == 1)
            %attenuation = attenuation .* exp(-0.3425 .* mu')'; 
            %attenuation = attenuation .* exp(-0.188 .* ATT(1, :))'; 
            %attenuation = attenuation .* exp(-0.501 .* ATT(1, :))'; 
            
            attenuation = attenuation .* exp(-0.033 .* ATT(1, :))'; 
            
            %attenuation = attenuation .* exp(-0.3425 .* ATT(1, :))'; 
            %attenuation = attenuation .* exp(-0.032 .* ATT(1, :))'; 
        
        end
        
        
                
        %attenuation = exp(-0.188 * ATT(1, :))';
        
        text = 'direct theory';
        
        saveFile = 'recon_inc';
        
    elseif (experiment == 2)
        
        % 
        % 
        
        %normFactor = (3 / 6) * 6 / 4;
        normFactor = 5 / 3;
        
        %normFactor = 0.1 / 1.5;
        %normFactor = 0.2 / 0.6;
        %normFactor = (500 / 200) * (0.1 / 1);
        
        spectrumFile = '1004.txt';
        experimentCode = code;
        
        % 1015 al 1.88, 1016 cu 0.32
        %region.left = 70; region.right = 120; region.top = 20; region.bottom = 120; 
        % 1017 al 3.425
        %region.left = 50; region.right = 100; region.top = 20; region.bottom = 120; 
        
        % 1030 al 1.88
        %region.left = 20; region.right = 110; region.top = 20; region.bottom = 130;
        
        %experimentCode = 1150;
        region.left = 40; region.right = 130; region.top = 50; region.bottom = 200;
        %region.left = 40; region.right = 220; region.top = 50; region.bottom = 200;
        
        %%% 1040 - inc, 1041 - 1.88 al, 1042 - 3.45 al, 1043 - 5.01 al, 1044 - 0.32 cu
        
        experimentCode = 1044;
        region.left = 20; region.right = 256 - 20; region.top = 20; region.bottom = 256 - 20;

        color = '.-b';
        
        attenuation = ones(incBins, 1);
         
        text = 'after al';
        
        saveFile = 'recon_measure';
        
    end
    






statRange = 200:200
statRange2 = 42;%:10:102;
C = zeros(size(statRange, 2), 1)
%DEVA = zeros(size(statRange, 2), 4);
TIMES = zeros(size(statRange2, 2), 4);
gyind = 1;
% 
%for gy = statRange
%     
%for gy2 = statRange2

%%% ---- Incident and Deposited ranges ----


%%% ---- Model data ----

if model == 1

    %Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 80, 3, 20);
    
    gg = modelResponse(spectrumRange, depositionRange, 'Gaussian', 80, 3);
    %Rij = loadAFL();
    %Rij = loadAFL();
    %Rij(:, 1:4) = gg(:, 1:4);
    
    %Rij = gg;
     %plot(1:size(Rij(:, 1)), Rij(:, 1), '.-b'); hold on;
     %return;
     Rij = gg;
     
    incident = modelSpectrum(spectrumRange, 200, 30, 20);
    %incident = poissrnd(incident);
    
    
    %incident(11) = 200;
%     
%     plot(spectrumRange, incident, '.-b');
%     return;
    
    %INC = incident;
% 
%     ds = dataset('File','geantspectrum.txt');
%     dd = double(ds);
%     incident = dd;

%     Rij = zeros(dn, n);
%     index = 1;
%     for j = spectrumRange
%         Rij(:, index) = piecewiseBuild(j);
%         index = index + 1;
%     end

    DEPOS = (incident)' * Rij';

%%% ---- Real data ----

else 
%     Rij = zeros(dn, n);
%     index = 1;
%     for j = spectrumRange
%         Rij(:, index) = piecewiseBuild(j);
%         index = index + 1;
%     end
% 
%     measurements = 1;
%     poly_ = zeros(dn, measurements);
% 
%     for measure = 1:measurements
%         ds = dataset('File',sprintf('thrafl/%d_%d.txt', 1000000, measure - 1));
%         dd = double(ds);
%         x = dd(:,1)';
%         y = dd(:,2)';
% 
%         poly_(:, measure) = y(1:26);
%     end
% 
%     poly = zeros(dn, 1);
%     for i = 1:dn
%         for measure = 1:measurements
%             poly(i) = poly(i) + poly_(i, measure);
%         end
% 
%         poly(i) = poly(i) / measurements;
% 
%     end
%     DEPOS = poly';

    %Rij2= loadAFL();
    
%     Rij = genAFLFromReflex('//192.168.0.105/work/politeh/thrscan/bias200clock16', ...
%         200, ...
%         40, 180, ...
%         20:30, ...
%         1, ...
%         3);        
%     
%     Rij = genAFLFromReflex('//192.168.0.105/work/politeh/thrscan/bias200clock16', ...
%         200, ...
%         60, 140, ...
%         20:30, ...
%         1, ...
%         3);    
% 
%     Rij3= loadAFL();
%     
%     figure(2);
%         
% 
%     for e = 1
%         %depositionRange = 16:2:32; 
%         plot(depositionRange, Rij(:, e), '.-r'); hold on;
%         plot(depositionRange, Rij2(:, e), '.-b'); hold on;
%     end
%         
%         
%     %end
%     return;

    
    DEPOS = loadDepositedSpectrum(path, experimentCode, deposOffset, region, deposIterationsTo);
    DEPOS = [DEPOS zeros(1, size(Rij, 1) - size(DEPOS, 2)) ] 
    %DEPOS = [DEPOS 0 0];
    %D = loadDepositedSpectrum(path, 1011, deposOffset, region);
    %D = D(1:size(depositionRange, 2));
    %DEPOS = DEPOS + D;
    %return;
    %DEPOS = loadDepositedSpectrum(path, experimentCode, deposOffset);
    
%      plot(depositionRange, DEPOS, '.-r'); hold on;
%      return;
    
    %DEPOS = loadDepositedSpectrum('1000.txt');
    
    
%     
%     deposBins = size(Rij, 1);
%     incBins = size(Rij, 2);
%     %spectrumRange = 1:incBins;
%     spectrumRange = double(1000+idivide(int32(step), 2):step:1000+idivide(int32(step), 2) + step*(incBins-1)) * 0.0146 - 0.1735;
%     depositionRange = 1:deposBins;
    
% 

        
   
    
    

end

%%% ---- Inaccurate response ----


if inaccurate_response == 1
    
    if (model == 1)
         Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 80, 3, 20, inaccurate_percent);
        
        %spectrumRange = 20.08:1.752/1:20.08+1.752*31;
        %depositionRange = 20.08:1.752/1:20.08+1.752*31; 
        
%         spectrumRange = 1:32;
%         depositionRange = 1:32;
%         
%         Rij_ = zeros(size(depositionRange, 2), size(spectrumRange, 2));
%         for e = 1:32
%             Rij_(:, e) = sum(reshape(Rij(:, e*4), 4, 32), 1);
%         end
%         Rij = Rij_;
        
        
        
        %D = (inc)' * Rij';
        
        
        %plot(1:32, Rij(:, 3), '.-b');
        %return;
% 
%         DEPOS = sum(reshape(DEPOS, 4, 32), 1);
%         incident = sum(reshape(incident, 4, 32), 1);
        
%          plot(1:32, D, '.-b'); hold on;
%          plot(1:32, DEPOS, '.-r'); hold on;
%          return;
%        DEPOS = D;
        
%         
%         n = size(spectrumRange, 2)
%         dn = size(depositionRange, 2)
        
        
%         Rij = zeros(dn, n);
%         index = 1;
%         for j = spectrumRange
%             Rij(:, index) = piecewiseBuild(j, inaccurate_percent);
%             index = index + 1;
%         end        
    else
        Rij = zeros(dn, n);
        
        index = 1;
        for j = spectrumRange
            Rij(:, index) = piecewiseBuild(j, inaccurate_percent);
            index = index + 1;
        end
    end
end


%%% ---- Energy reconstruction ----

%%% ---- ---- Spectrum Stripping ----

if spectrum_stripping == 1
    disp('spectrum stripping...');

    tic;
    
    conv = DEPOS;
    result = zeros(n, 1);

    for e = n-2:-1:3

        disp(sprintf('%d', e));


        %result(e) = conv(1) / Rij(1, e);
        result(e) = conv(e - 2) / Rij(e - 2, e);
        %result(e) = conv(e) / Rij(e, e);

            for xx = 1:dn
                conv(xx) = conv(xx) - result(e) * Rij(xx, e);
            end

    end
    
    tictoc_spectrum_stripping = toc;
    
end

%%% ---- ---- Matlab opimizer ----

if matlab_optimizer == 1

    tic;
    
    x0 = zeros(n, 1);

    A = [];
    b = [];
    Aeq = [];
    beq = [];
    nonlcon = [];

    lb = [];
    ub = [];
    lb = zeros(n, 1);
    ub = zeros(n, 1);


    for i = 1:n
       lb(i) = 1;
       ub(i) = 10000000000;
    end

    %[xxx, fval, exitflag] = fmincon(@(xxx) fname_mlem(xxx,DEPOS',Rij), double(x0), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals', 10000, 'MaxIter', 100, 'TolX', 0.01, 'Algorithm', 'active-set') );
    [xxx, fval, exitflag] = fmincon(@(xxx) fname_mlem(xxx,DEPOS',Rij), double(x0), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals', 10000, 'MaxIter', 10000, 'TolX', 0.0001, 'Algorithm', 'active-set') );
    

    tictoc_matlab_optimizer = toc;
    
end

%%% ---- ---- SART ----

if sart_recon == 1

    tic
    
    tol = 1e-8; maxit = 100;

    optionsSART.nonneg = true;

    x0 = zeros(size(Rij, 2), 1);

    [incident_sle, info] = sart(Rij, double(DEPOS'), iterationsNumber, x0, optionsSART);
    
    tictoc_sart_recon = toc;

end

%%% ---- ---- ML-EM (Ruizhe Li et al 2017 (China)) ----

if mlem_itr_recon == 1

    tic
    
    s = ones(n, 1) * 1;
    snext = zeros(n, 1);

    for itr = 1:iterationsNumber
        
        F = s' * Rij';
        
        for j = 1:n
            sum2 = 0;
            for i = 1:dn

%                 sum1 = 0;
%                 for k = 1:n
%                     sum1 = sum1 + Rij(i, k) * s(k);
%                 end
% 
%                sum2 = sum2 + Rij(i, j) * (DEPOS(i) / sum1);

                if (F(i) == 0) continue; end
                sum2 = sum2 + Rij(i, j) * (DEPOS(i) / F(i));
            end

            snext(j) = s(j) * sum2;

        end

        s = snext;
        %s
        
%         if (isnan(s(1))) 
%             itr 
%             pause();
%         end

    end
    
    incident_mlem_itr = s;
    
    tictoc_mlem_itr_recon = toc
   
    
end

%%% ---- Output ----

%INC_ = incident_sle;

%plot(spectrumRange, incident, '.-b'); hold on;

% avg = sum(incident)/size(incident, 1);
% sqrt(avg) / avg

% if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Spectrum'); hold on; end    
% if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, result), percentdev(incident, result), tictoc_spectrum_stripping)); hold on; end
% if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, xxx), percentdev(incident, xxx), tictoc_matlab_optimizer) ); hold on; end
% if (sart_recon) plot(spectrumRange, incident_sle, '.-g', 'DisplayName', sprintf('SART rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, incident_sle), percentdev(incident, incident_sle), tictoc_sart_recon) ); hold on; end
% if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr, '.-r', 'DisplayName', sprintf('ML-EM Itr rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, incident_mlem_itr), percentdev(incident, incident_mlem_itr), tictoc_mlem_itr_recon) ); hold on; end


% if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Spectrum'); hold on; end    
% if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction rsquare %.3f', deviation(incident, result))); hold on; end
% if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction rsquare %.3f', deviation(incident, xxx)) ); hold on; end
% if (sart_recon) plot(spectrumRange, incident_sle, '.-g', 'DisplayName', sprintf('SART rsquare %.3f', deviation(incident, incident_sle)) ); hold on; end
% if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr, '.-r', 'DisplayName', sprintf('ML-EM Itr rsquare %.3f', deviation(incident, incident_mlem_itr)) ); hold on; end



%if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction ') ); hold on; end
%return

if (show_recon == 1)
% % 

if (comparison ~= 1)
    if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Geant4 modeled spectrum'); hold on; end    
    if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction ')); hold on; end
    if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction ') ); hold on; end
    %if (sart_recon) plot(spectrumRange, incident_sle ./ resultFactor, '.-g', 'DisplayName', sprintf('SART')); hold on; end
    if (sart_recon) plot(spectrumRange, incident_sle ./ resultFactor, char(colors(colorIndex)), 'DisplayName', sprintf('SART')); hold on; end
    if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr ./ resultFactor, '.-r', 'DisplayName', sprintf('ML-EM Itr ') ); hold on; end
    
else

    %g = incident_sle .* exp(-0.5 .* ATT(1, :))';
     %g(1) = 1;
     %g(2) = 1;
    % 
    % 
    % 
    x = spectrumRange;

    if (sart_recon)
        y = incident_sle .* normFactor;
    elseif (mlem_itr_recon)
        y = incident_mlem_itr .* normFactor;
    elseif (matlab_optimizer)
        y = xxx .* normFactor; 
    end
    %

    spectrum = y;
    save(saveFile, 'spectrum');

    y = y .* attenuation;

    if (experiment == 2)
        y1 = yprev;
        ind = abs(y - y1) < sqrt(y) * 2;
        %ind

        e = errorbar(x(ind),y(ind),sqrt(y(ind)) * 2);
        e.Color = 'b';
        e.LineStyle = 'none';

        e = errorbar(x(~ind),y(~ind),sqrt(y(~ind)) * 2);
        e.Color = 'r';
        e.LineStyle = 'none';
        
        
        %mu = log(yprev ./ y) ./ 0.188;

    %     mu = log(yprev ./ y) ./ 0.188;
    %     
    %     plot(1:incBins, mu, '.-b'); hold on;
    %     plot(1:incBins, ATT(1, :), '.-r'); hold on;
    %     return;

    end

    yprev = y;

    plot(x, y, color, 'DisplayName', text );  hold on;

end


%plot(1:size(DEPOS, 2), DEPOS, color, 'DisplayName', text );  hold on;

% plot(1:size(incident_sle, 1), incident_sle, '.-b', 'DisplayName', text );  hold on;
% plot(1:size(incident_sle, 1), incident, '.-r', 'DisplayName', text );  hold on;


legend('show');


end


end


%end


% DEVA(gyind, 1) = percentdev(incident, result);
% DEVA(gyind, 2) = percentdev(incident, xxx);
% DEVA(gyind, 3) = percentdev(incident, incident_sle);
% DEVA(gyind, 4) = percentdev(incident, incident_mlem_itr);
% C(gyind) = sum(incident)/size(incident, 1);


% TIMES(gyind, 1) = tictoc_spectrum_stripping;
% %TIMES(gyind, 2) = tictoc_matlab_optimizer;
% TIMES(gyind, 3) = tictoc_sart_recon;
% TIMES(gyind, 4) = tictoc_mlem_itr_recon;
% C(gyind) = gy2;
% % 
% gyind = gyind + 1;
% 
% 
% 
%end
% 
% end

% plot(C, DEVA(:, 1), '.-m', 'DisplayName', 'Spectrum Stripping'); hold on;
% %plot(C, DEVA(:, 2), '.-k', 'DisplayName', 'MLEM active-set optimizer'); hold on;
% plot(C, DEVA(:, 3), '.-g', 'DisplayName', 'SART'); hold on;
% plot(C, DEVA(:, 4), '.-r', 'DisplayName', 'MLEM (itr)'); hold on;
% xlabel('Photon count');
% ylabel('Deviation, %');
% legend('show');

% plot(C, TIMES(:, 1), '.-m', 'DisplayName', 'Spectrum Stripping'); hold on;
% %plot(C, TIMES(:, 2), '.-k', 'DisplayName', 'MLEM active-set optimizer'); hold on;
% plot(C, TIMES(:, 3), '.-g', 'DisplayName', 'SART'); hold on;
% plot(C, TIMES(:, 4), '.-r', 'DisplayName', 'MLEM (itr)'); hold on;
% xlabel('Incident bins');
% ylabel('Time, s');

if (show_recon == 0)
    
%     plot(depositionRange, result' * Rij', '.-m', 'DisplayName', 'Forward Sectrum Stripping');  hold on;
%     plot(depositionRange, incident_sle' * Rij', '.-g', 'DisplayName', 'Forward SART');  hold on;
%     plot(depositionRange, incident_mlem_itr' * Rij', '.-r', 'DisplayName', 'Forward ML-EM Itr');  hold on;
    
%     plot(depositionRange, incident_sle' * Rij', '.-r');  hold on;
    plot(depositionRange, incident_sle' * Rij', '.-r');  hold on;
    plot(depositionRange, DEPOS, '.-k', 'DisplayName', 'Detected'); hold on;
end

legend('show');

%print(sprintf('plots/spectral_state2/ag'), '-dpng');



 



