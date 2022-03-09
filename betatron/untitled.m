
% % 154500000 events processed.
% 
% [x, y] = loadXY('/home/fna/dev/geant4/betatron/build/out/spectrum.txt');
% 
% x = x(1:1000);
% y = y(1:1000);
% plot(x, y, '.-r');
% xlabel('Energy, kEv');
% ylabel('Counts per 154500000 events');
% 
% 
% sum(y)

files = {
    'spectrum_0'
    'spectrum_35'
    'spectrum_15'
    'spectrum_55'
    };

colorIndex = 1;

figure('rend', 'painters', 'pos', [500 500 1100 800]);

subplot(2,1,1);
suptitle({'', 'spectra for 211500000 e-'});   

for i=1:numel(files)
    
    % solid
    r1 = [-125 -1002 125];
    r2 = [-125 -1002 -125];
    r3 = [125 -1002 -125];
    r4 = [125 -1002 125];
    w_gather = solidAngleTriangle(r1, r2, r3)  + solidAngleTriangle(r3, r4, r1)

    r1 = [-1 -1002 1];
    r2 = [-1 -1002 -1];
    r3 = [1 -1002 -1];
    r4 = [1 -1002 1];
    w_gather2 = solidAngleTriangle(r1, r2, r3)  + solidAngleTriangle(r3, r4, r1)

    k = w_gather2 / w_gather;


    % radial beam norm
    k = k*(0.013*2)/(pi*4);
    
    if (i == 1)
        k = k*211500000/153000000;
    end

    %211500000
    % for 0 - 153000000    

    [x, y] = loadXY(sprintf('/home/fna/dev/geant4/betatron/build/out/%s.txt', char(files(i))));
    %x = x(1:2000);
    %y = y(1:2000);
    plot(x, k*(y), char(colors(colorIndex)), 'DisplayName', str(char(files(i))), 'LineWidth',2); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end      

    sum(y)
end

title('linear');
xlabel('Energy, kEv');
ylabel('XRay Counts, N (for 211500000 e-)');
legend('show');



colorIndex = 1;
subplot(2,1,2);


for i=1:numel(files)
    
    % solid
    r1 = [-125 -1002 125];
    r2 = [-125 -1002 -125];
    r3 = [125 -1002 -125];
    r4 = [125 -1002 125];
    w_gather = solidAngleTriangle(r1, r2, r3)  + solidAngleTriangle(r3, r4, r1)

    r1 = [-1 -1002 1];
    r2 = [-1 -1002 -1];
    r3 = [1 -1002 -1];
    r4 = [1 -1002 1];
    w_gather2 = solidAngleTriangle(r1, r2, r3)  + solidAngleTriangle(r3, r4, r1)

    k = w_gather2 / w_gather;


    % radial beam norm
    k = k*(0.013*2)/(pi*4);
    
    if (i == 1)
        k = k*211500000/153000000;
    end

    %211500000
    % for 0 - 153000000    

    [x, y] = loadXY(sprintf('/home/fna/dev/geant4/betatron/build/out/%s.txt', char(files(i))));
    %x = x(1:2000);
    %y = y(1:2000);
    plot(x, log10(k*(y)), char(colors(colorIndex)), 'DisplayName', str(char(files(i))), 'LineWidth',2); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end


    sum(y)
end

title('log');
xlabel('Energy, kEv');
ylabel('XRay Counts, N (for 211500000 e-)');
legend('show');
