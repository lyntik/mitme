

%figure('Renderer', 'painters', 'Position', [10 10 900 720])
figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

src = {'am241'
    %'ba133'
    %'co57'
    };

colorIndex = 1;
i = 3;



for s=src

    [x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/sources/%s/%d.txt', char(s), i)); 
    
     x = x(4:200);
     y = y(4:200);
    
    %y = y ./ sum(y);
     
   
    plot((x), log(y), char(colors(colorIndex)), 'DisplayName', char(s)); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end    
    
%     [x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/%d.txt', i)); hold on;
%     x = x(6:300);
%     y = y(6:300);
%     
%     plot((x), log(y), char(colors(colorIndex)), 'DisplayName', sprintf('%d', i));
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end        
    
end

%ylim([0 inf]);

xlabel('TOT');
ylabel('Intensity, N (log)');
%title(sprintf('Radioactive sources. %d cluster', i));
legend('show');
print('-clipboard','-dbitmap');

%[x y] = loadXY('/home/fna/dev/pixetsdk/2.txt'); hold on;

return;
