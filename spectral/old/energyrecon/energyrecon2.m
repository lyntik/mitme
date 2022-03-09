
global gyyy;
global MDE;
gyyy = 0;

colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };

thr = 0;

model = 1;
    inaccurate_response = 0 % if model
    inaccurate_percent = 10
    
spectrum_stripping = 1;
matlab_optimizer = 0;
sart_recon = 1;
mlem_itr_recon = 1;

check_forward = 0; 

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

% spectrumRange = 19:1:42; 
% depositionRange = 20:1:45; 

% 
% spectrumRange = 19:1:1000; 
% depositionRange = 19:1:1000; 

spectrumRange = 19:1:gy2; 
depositionRange = 20:1:45; 

% % 
spectrumRange = 0.6:0.1:100.5; 
depositionRange = 0.6:0.1:100.5; 

n = size(spectrumRange, 2);
dn = size(depositionRange, 2);

%%% ---- Model data ----

if model == 1

    Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 80, 3, 20);
    %Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 80, 3);
    incident = modelSpectrum(spectrumRange, 200, 30, 20);
    
    %incident(11) = 200;
%     
%     plot(spectrumRange, incident, '.-b');
%     return;
    
    %INC = incident;
% 
    ds = dataset('File','geantspectrum.txt');
    dd = double(ds);
    incident = dd;

%     Rij = zeros(dn, n);
%     index = 1;
%     for j = spectrumRange
%         Rij(:, index) = piecewiseBuild(j);
%         index = index + 1;
%     end

    DEPOS = poissrnd(incident)' * Rij';



%%% ---- Real data ----

else 
    Rij = zeros(dn, n);
    index = 1;
    for j = spectrumRange
        Rij(:, index) = piecewiseBuild(j);
        index = index + 1;
    end

    measurements = 1;
    poly_ = zeros(dn, measurements);

    for measure = 1:measurements
        ds = dataset('File',sprintf('thrafl/%d_%d.txt', 1000000, measure - 1));
        dd = double(ds);
        x = dd(:,1)';
        y = dd(:,2)';

        poly_(:, measure) = y(1:26);
    end

    poly = zeros(dn, 1);
    for i = 1:dn
        for measure = 1:measurements
            poly(i) = poly(i) + poly_(i, measure);
        end

        poly(i) = poly(i) / measurements;

    end
    DEPOS = poly';

end

%%% ---- Inaccurate response ----

if inaccurate_response == 1
    
    if (model == 1)
        Rij = modelResponse(spectrumRange, depositionRange, 'TailedGaussian', 80, 3, 20, inaccurate_percent); 
        
        Rij = zeros(dn, n);
        index = 1;
        for j = spectrumRange
            Rij(:, index) = piecewiseBuild(j, inaccurate_percent);
            index = index + 1;
        end        
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

    [incident_sle, info] = sart(Rij, double(DEPOS'), 1000, x0, optionsSART);
    
    tictoc_sart_recon = toc;

end

%%% ---- ---- ML-EM (Ruizhe Li et al 2017 (China)) ----

if mlem_itr_recon == 1

    tic
    
    s = ones(n, 1);
    snext = zeros(n, 1);

    for itr = 1:1000
        
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

avg = sum(incident)/size(incident, 1);
sqrt(avg) / avg

% if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Spectrum'); hold on; end    
% if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, result), percentdev(incident, result), tictoc_spectrum_stripping)); hold on; end
% if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, xxx), percentdev(incident, xxx), tictoc_matlab_optimizer) ); hold on; end
% if (sart_recon) plot(spectrumRange, incident_sle, '.-g', 'DisplayName', sprintf('SART rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, incident_sle), percentdev(incident, incident_sle), tictoc_sart_recon) ); hold on; end
% if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr, '.-r', 'DisplayName', sprintf('ML-EM Itr rsquare %.3f percentdev %.3f time %.3f s', deviation(incident, incident_mlem_itr), percentdev(incident, incident_mlem_itr), tictoc_mlem_itr_recon) ); hold on; end


if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Spectrum'); hold on; end    
if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction rsquare %.3f', deviation(incident, result))); hold on; end
if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction rsquare %.3f', deviation(incident, xxx)) ); hold on; end
if (sart_recon) plot(spectrumRange, incident_sle, '.-g', 'DisplayName', sprintf('SART rsquare %.3f', deviation(incident, incident_sle)) ); hold on; end
if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr, '.-r', 'DisplayName', sprintf('ML-EM Itr rsquare %.3f', deviation(incident, incident_mlem_itr)) ); hold on; end

legend('show');


% if (model) plot(spectrumRange, (incident), '.-b', 'DisplayName', 'Geant4 modeled spectrum'); hold on; end    
% if (spectrum_stripping) plot(spectrumRange, result, '.-m', 'DisplayName', sprintf('Spectrum Stripping reconstruction ')); hold on; end
% if (matlab_optimizer) plot(spectrumRange, xxx, '.-k', 'DisplayName', sprintf('MLEM active-set optimizer reconstruction ') ); hold on; end
% if (sart_recon) plot(spectrumRange, incident_sle, '.-g', 'DisplayName', sprintf('SART ')); hold on; end
% if (mlem_itr_recon) plot(spectrumRange, incident_mlem_itr, '.-r', 'DisplayName', sprintf('ML-EM Itr ') ); hold on; end
% 

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

if (check_forward == 1)
    
%     plot(depositionRange, result' * Rij', '.-m', 'DisplayName', 'Forward Sectrum Stripping');  hold on;
%     plot(depositionRange, incident_sle' * Rij', '.-g', 'DisplayName', 'Forward SART');  hold on;
%     plot(depositionRange, incident_mlem_itr' * Rij', '.-r', 'DisplayName', 'Forward ML-EM Itr');  hold on;
    
%     plot(depositionRange, incident_sle' * Rij', '.-r');  hold on;
%     plot(depositionRange, incident_sle' * Rij', '.-r');  hold on;
    plot(depositionRange, DEPOS, '.-k', 'DisplayName', 'Detected'); hold on;
end

legend('show');





 


