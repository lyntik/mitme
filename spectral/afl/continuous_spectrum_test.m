
% zagrub works the same in any case:
% - increase spectral step width;
% - zagrub detected afl;
% inaccurate pics are presented for this test



spectrumRange = 1:1:1000;
depositionRange = 1:1:1000;

% ideal case
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(Rij, 2), 1);
% [incident_sle, info] = sart(Rij, double(D'), 1000, x0, optionsSART);
% 
% plot(1:1000, incident_sle, '.-g'); hold on;
% legend('show');


%%% skipped spectrum
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% R = zeros(1000, 50);
% j = 1;
% for i = 1:2:100
%     R(:, j) = merge_afls(Rij, (i - 1) * 10 + 1, i * 10);
%     j = j + 1;
% end
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(R, 2), 1);
% [incident_sle, info] = sart(R, double(D'), 1000, x0, optionsSART);
% 
% plot(1:50, incident_sle, '.-g'); hold on;
% legend('show');

%%% overlapped spectrum
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% R = zeros(1000, 300);
% j = 1;
% for i = 1:1:100
%     R(:, (j - 1) * 3 + 1) = merge_afls(Rij, (i - 1) * 10 + 1, i * 10);
%     R(:, j * 3 - 1) = merge_afls(Rij, (i - 1) * 10 - 5, i * 10 - 5);
%     R(:, j * 3) = merge_afls(Rij, (i - 1) * 10 - 3, i * 10 - 3);    
%     j = j + 1;
% end
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(R, 2), 1);
% [incident_sle, info] = sart(R, double(D'), 1000, x0, optionsSART);
% 
% plot(1:300, incident_sle, '.-g'); hold on;
% legend('show');

%%% inaccurate
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30, 10, 10);
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(Rij, 2), 1);
% [incident_sle, info] = sart(Rij, double(D'), 1000, x0, optionsSART);
% 
% plot(1:1000, incident_sle, '.-g'); hold on;
% legend('show');

%%% inaccurate, zagrub - by spectral step some width 
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30, 10, 10);
% 
% R = zeros(1000, 100);
% j = 1;
% for i = 1:1:100
%     R(:, j) = merge_afls(Rij, (i - 1) * 10 + 1, i * 10); 
%     j = j + 1;
% end
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(R, 2), 1);
% [incident_sle, info] = sart(R, double(D'), 1000, x0, optionsSART);
% 
% plot(1:100, incident_sle, '.-g'); hold on;
% legend('show');

%%% inaccurate, zagrub - by detected signal some width
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30);
% INC = modelSpectrum(spectrumRange, 500, 500, 200);
% D = INC' * Rij';
% 
% Rij = modelResponse(spectrumRange, depositionRange, 'Gaussian', 1, 30, 10, 10);
% 
% RR = zeros(100, 1000);
% for i = 1:1000
%     RR(:, i) = sum(reshape(Rij(:, i), 10, 100), 1)';
% end
% DD = sum(reshape(D, 10, 100), 1);
% 
% optionsSART.nonneg = true;
% x0 = zeros(size(RR, 2), 1);
% [incident_sle, info] = sart(RR, double(DD'), 1000, x0, optionsSART);
% 
% plot(1:1000, incident_sle, '.-g'); hold on;
% legend('show');



