function plotMeasuresWithDiffrence(path, exps, f)

    global colors;
    
    exps_ = strrep(exps, '_', '\_');

    figure('rend', 'painters', 'pos', [500 500 1100 800]);
    subplot(2,1,1);
    suptitle({'', 'blablabla spectrometer characterization'}); 

    colorIndex = 1;
    for i = 1:numel(exps)

        [y] = loadMCA(sprintf('%s/%s.mca', path, char(exps(i))));
        y = y(1:4000);

        y = reshape(y, [4, 1000]);
        y = sum(y, 1);

        if (i == 1) y1 = y;
        elseif (i == 2) y2 = y;
        end

        plot(f(1:4:numel(y)*4), y, char(colors(colorIndex)), 'DisplayName', sprintf('%s', char(exps_(i)))); hold on;
        colorIndex = colorIndex + 1;
        if (colorIndex == 8)
            colorIndex = 1;
        end
    end
    
    ydiff = y1 - y2;
    plot(f(1:4:numel(y)*4), ydiff, char(colors(colorIndex)), 'DisplayName', 'diff'); hold on;
    title('linear'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');


    subplot(2,1,2);

    colorIndex = 1;
    for i = 1:numel(exps)
        [y] = loadMCA(sprintf('%s/%s.mca', path, char(exps(i))));
        y = y(1:4000);

        y = reshape(y, [4, 1000]);
        y = sum(y, 1);    

        plot(f(1:4:numel(y)*4), log10(y), char(colors(colorIndex)), 'DisplayName', sprintf('%s', char(exps_(i)))); hold on;
        colorIndex = colorIndex + 1;
        if (colorIndex == 8)
            colorIndex = 1;
        end
    end
    
    plot(f(1:4:numel(y)*4), log10(ydiff), char(colors(colorIndex)), 'DisplayName', 'diff'); hold on;

    title('log10'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');


end



