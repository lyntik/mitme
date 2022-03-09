
global XRAY_BASE_PATH;

colorIndex = 1;

inDir = '/media/fna/storage 2T/bring/data/geant/ba_dose/old/50x50/6mm';
%inDir = '/home/fna/dev/ba_dose/build';
outDir = '/home/fna/data/geant4/ba_dose';


dumpIncComparisonMiddlePixel = 0;
dumpIncComparisonNearbyWithMiddlePix = 0;
dumpIncDeposMiddlePixel = 0;
dumpDeposScintillatorMiddlePixel = 0;
dumpEnergyDoseDole = 0;
whichiSDose = 0;
dumpDoses = 1;


conf =  2;
thick = 6; % mm

fileID = fopen(sprintf('%s/%d/descr.txt', inDir, conf), 'r');
events = double(fscanf(fileID, '%lu'));
fclose(fileID);
%events = 500000000;
seconds = (events / 2.5378) / (370000000 * 0.7);


index = 1;

%%%%%%%%%%%%%%%%%%%%---  inc comparison, middle pixel
 

if dumpIncComparisonMiddlePixel == 1
    pixelX = 0;
    pixelY = 0;
    
    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    suptitle({sprintf('inc spectrum, middle pixel, front/back panels, exposure %.3f seconds', seconds),''})
    subplot(2,1,1);
    
    matrix = 6;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-b', 'DisplayName', 'front'); hold on;
    
%     str = '';
%     str2 = '';
%     for i = 0:499
%         %str = strcat(str, sprintf('%.3f* keV', y(i+1)), {' '});
%         str = [str sprintf('%.3f*keV, ', i+1)];
%         str2 = [str2 sprintf('%.3f, ', y(i+1))];
%     end
%     str
%     str2
% 
%     return;
    
    matrix = 1;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-r', 'DisplayName', 'back'); hold on;
    
    title('linear');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
    %%% 
    subplot(2,1,2);
    
    matrix = 6;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-b', 'DisplayName', 'front'); hold on;

    matrix = 1;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-r', 'DisplayName', 'back'); hold on;
    
    title('log10');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
    %return;
    
    print(sprintf('%s/%02d-inc-middle', outDir, index), '-dpng');
    close all;
    
    
end


index = index + 1;

%%%%%%%%%%%%%%%%%%%%---  inc comparison, nearby with middle pixel

if dumpIncComparisonNearbyWithMiddlePix == 1

    pixelX = 0;
    pixelY = 0;
    
    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    suptitle({sprintf('inc spectrum, nearby of middle pixel, front/back/left panels, exposure %.3f seconds', seconds),''})
    subplot(2,1,1);

    matrix = 0;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-b', 'DisplayName', 'front'); hold on;

    matrix = 1;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-r', 'DisplayName', 'back'); hold on;
    
    matrix = 2;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-g', 'DisplayName', 'left'); hold on;   
    
    title('linear');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
    %%% 
    subplot(2,1,2);

    matrix = 0;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-b', 'DisplayName', 'front'); hold on;

    matrix = 1;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-r', 'DisplayName', 'back'); hold on;
    
    matrix = 2;
    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-g', 'DisplayName', 'left'); hold on;   
    
    title('log10');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');    
    
    
    print(sprintf('%s/%02d-inc-nearby-middle', outDir, index), '-dpng');
    close all;
    
end

index = index + 1;


%%%%%%%%%%%%%%%%%%%%---  inc->depos

if dumpIncDeposMiddlePixel == 1
    pixelX = 0;
    pixelY = 0;
    matrix = 0;
    
    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    suptitle({sprintf('inc->depos (%dmm), middle pixel, front panel, exposure %.3f seconds', thick, seconds),''})
    subplot(2,1,1);    

    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y, '.-b', 'DisplayName', 'inc'); hold on;
    
    fprintf('inc %.3f\n', y(357) / seconds / 36 );
    
    [x, y] = loadXY(sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y, '.-r', 'DisplayName', 'deposit'); hold on;
    
    %[x, y] = loadXY(sprintf('/home/fna/data/geant/ba_dose/new/measure/%d/dumpDeposit/%d/%02d_%02d.txt', conf, matrix, pixelX, pixelY)); % i hope center the same =)
    %plot(x, y .* 2.22, '.-g', 'DisplayName', 'deposit 2 mm'); hold on;
    
    title('linear');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
    p = 7.1;
    m = thick * 6 * 6 * 10^-3 * p / 1000; % in kg
    d = sum(x .* y);
    
    fprintf('dose high only %.4f\n', y(357) * 356 * (10^3 * 1.6021766209 * 10^-19  / m) *  (3600 / seconds) );
    fprintf('dose %.3f\n', d * (10^3 * 1.6021766209 * 10^-19  / m) *  (3600 / seconds) );
    fprintf('count of all deposit %.3f\n', sum(y) / seconds );
    
    return;
    
    %%% 
    subplot(2,1,2);

    [x, y] = loadXY(sprintf('%s/%d/dumpInc/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y, '.-b', 'DisplayName', 'inc'); hold on;
    
    [x, y] = loadXY(sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y, '.-r', 'DisplayName', 'deposit'); hold on;

%     [x, y] = loadXY(sprintf('/home/fna/data/geant/ba_dose/new/measure/%d/dumpDeposit/%d/%02d_%02d.txt', conf, matrix, pixelX, pixelY)); % i hope center the same =)
%     plot(x, log10(y .* 2.22), '.-g', 'DisplayName', 'deposit 2 mm'); hold on;    
    
    title('log10');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
    return;
    
    print(sprintf('%s/%02d-inc-depos-middle', outDir, index), '-dpng');
    close all;
    
    
end

index = index + 1;


%%%%%%%%%%%%%%%%%%%%---  depos->"scintillator detection"

if dumpDeposScintillatorMiddlePixel == 1
    pixelX = 15;
    pixelY = 15;
    matrix = 0;

    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    suptitle({sprintf('depos->"scintillator detection, middle pixel, front panel, exposure %.3f seconds', thick, seconds),''})
    subplot(2,1,1);        
    
    [x, y] = loadXY(sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    plot(x, y , '.-b', 'DisplayName', 'deposit'); hold on;
    
    matrix = 0;
    [x, y] = loadXY(sprintf('%s/%d/dumpCounts/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    
    %%%%%%%%%%%%% convert to data without reminder
        
        %%% reduce
        ind = find(y ~= 0);
        x = x(ind);
        y = y(ind);
        y_reduced = y; 
        for i = 2:numel(x)-1
        %      if (x(i) == 171)  
        %          reduceBinValueForDistrub(x(i-1:i+1)) 
        %      end
            y_reduced(i) = y(i) / reduceBinValueForDistrub(x(i-1:i+1));
        end
        y_reduced(1) = floor(y_reduced(2));
        y_reduced(end) = floor(y_reduced(end-1));
        x_reduced = [-1; x(1)-1; x; x(end)+1; 5001];
        y_reduced = [ 0; 0; y_reduced; 0; 0 ];
        
        %%% fit
        [xData, yData] = prepareCurveData( x_reduced, y_reduced );
        [fitresult, gof] = fit( xData, yData, 'pchipinterp', 'Normalize', 'on' );
        x_interp = 0:4999;
        y_interp = zeros(5000, 1);
        for i = x(1):4999
            y_interp(i) = feval(fitresult, i);
        end
        
        %%% reshape
        y_result = sum(reshape(y_interp, 10, 500), 1);
        y = y_result;
        x = 0:499;
        
    %%%%%%%%%%%%%
    
    
    plot(x, y , '.-r', 'DisplayName', 'scintillator detection'); hold on;
    
    title('linear');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
    
   
    %%% 
    subplot(2,1,2); 
    
    [x, y] = loadXY(sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    plot(x, y , '.-b', 'DisplayName', 'deposit'); hold on;
    
    matrix = 0;
    %[x, y] = loadXY(sprintf('%s/%d/dumpCounts/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY), true);
    y = log10(y_result);
    plot(x, y , '.-r', 'DisplayName', 'scintillator detection'); hold on;
    
    title('log10');
    xlabel('Energy, keV');
    ylabel('Counts, N');
    legend('show');
     
    print(sprintf('%s/%02d-depos-scin-middle', outDir, index), '-dpng');
    close all;
end

index = index + 1;

%%%%%%%%%%%%%%%%%%%%---  energy->dose, dole of deposition for each energy

if dumpEnergyDoseDole == 1
    pixelX = 15;
    pixelY = 15;
    matrix = 1;
    
    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    subplot(3,1,1);      
        
    [x, y] = loadXY(sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrix, pixelX, pixelY));
    y = y .* x;
    y = y ./ sum(y);
    plot(x, y , '.-b'); hold on;
    
    title('energy->dose, dole of deposition to dose for each energy, back');
    xlabel('Energy, keV');
    ylabel('%');   
    
    subplot(3,1,2);      
    
    [x, y] = loadXY(sprintf('%s/atts/fe.txt', XRAY_BASE_PATH));
    x = x(50:end) ./ 1000;
    y = y(50:end);
    plot(x, y , '.-b'); hold on;    

    title('Fe linear att coef');
    xlabel('Energy, keV');
    ylabel('mu');   
    
    subplot(3,1,3);   
    
    [x, y] = loadXY(sprintf('%s/atts/w.txt', XRAY_BASE_PATH));
    x = x(50:end) ./ 1000;
    y = y(50:end);
    plot(x, y , '.-b'); hold on;    

    title('W linear att coef');
    xlabel('Energy, keV');
    ylabel('mu');   
       
     print(sprintf('%s/%02d-energy-dose-dole', outDir, index), '-dpng');
     close all;
end

index = index + 1;

%%%%%%%%%%%%%%%%%%%%---  which is dose ??

if whichiSDose == 1
    
    experiment = 1006;
    
    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    suptitle({sprintf('LYSO %d experiment', experiment),''})
    subplot(2,1,1);
    [thicks, doses] = doseVersusThick('/home/fna/dev/dose/build', 1006);
    hPlot = plot(thicks, doses, '.-b'); hold on;
    title('Calculated dose for spectrum front, middle pixel');
    xlabel('Thickness, mm');
    ylabel('Dose');
    
    % tooltip
    cursorMode = datacursormode(gcf);
    set(cursorMode, 'enable','on');
    hTarget = handle(hPlot);
    hDatatip = cursorMode.createDatatip(hTarget);
    set(hDatatip, 'Position', [thicks(9) doses(9)]);
    
    subplot(2,1,2);
    [thicks, doses] = doseVersusThick('/home/fna/dev/dose/build', 30);
    plot(thicks, doses, '.-b', 'DisplayName', '30 kEv'); hold on;
    
    subplot(2,1,2);
    [thicks, doses] = doseVersusThick('/home/fna/dev/dose/build', 80);
    plot(thicks, doses, '.-r', 'DisplayName', '80 kEv'); hold on;
    
    subplot(2,1,2);
    [thicks, doses] = doseVersusThick('/home/fna/dev/dose/build', 350);
    plot(thicks, doses, '.-k', 'DisplayName', '350 kEv'); hold on;
    title('Calculated dose for different mono lines');
    xlabel('Thickness, mm');
    ylabel('Dose');
    
    legend('show');
    
    print(sprintf('%s/%02d-what_is_dose', outDir, index), '-dpng');
    close all;
end

index = index + 1;


%%%%%%%%%%%%%%%%%%%%---  dose distribution

if dumpDoses == 1
    
    p = 7.1;
    m = thick * 6 * 6 * 10^-3 * p / 1000; % in kg

    planes = {'front', 'back', 'left', 'right', 'bottom', 'top'};
    for matrixNumber = 0:5
        
        md = matrixDose(inDir, conf, matrixNumber);
        md = md .* (10^3 * 1.6021766209 * 10^-19  / m) *  (3600 / seconds); %* 3;
       
        imagesc(md);
                    
        colorbar; 
        title(sprintf("Dose in grey/hour for %s panel. Avg %.6f ugrey ", char(planes(matrixNumber + 1)), sum(sum(md))/numel(md)*1000000));
        xlabel('Detector column');
        ylabel('Detector row');
        truesize([600 600]);
        print(sprintf('%s/%02d-dose-distribution-%02d_%s', outDir, index, matrixNumber, char(planes(matrixNumber + 1))),  '-dpng');

        index = index + 1;
        
        close all;
        
%         if (matrixNumber == 0)
%             md(8:24, 8:24) = 0;
%             
%             imagesc(md .* (10^3 * 1.6021766209 * 10^-19  / m) *  (3600 / seconds) );
%                     
%             colorbar; 
%             title(sprintf("Dose in grey/hour for %s panel ", char(planes(matrixNumber + 1))));
%             xlabel('Detector column');
%             ylabel('Detector row');
%             truesize([600 600]);
%             print(sprintf('%s/%02d-dose-distribution-%02d_%s', outDir, index, matrixNumber, char(planes(matrixNumber + 1))),  '-dpng');
% 
%             index = index + 1;
% 
%             close all;            
%         end
        
    end

end




