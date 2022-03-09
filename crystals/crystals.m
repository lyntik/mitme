


figure(1);
p = get(gcf, 'position');
p(3) = p(3) * 2;
p(4) = p(4) * 2;
set(gcf, 'position', p);

[y] = loadASC('/home/fna/105/nitro/am2.asc');
y = y(1:3500);
x = 1:numel(y);
yyaxis left
plot(x, y, '.-k'); hold on;

set(gca,'YColor','k');

ylabel('N, count');

ax = gca;
ax.FontSize = 20; 
ax.FontWeight = 'bold';
ax.FontName = 'Times';
ax.LineWidth = 4;

yyaxis right
f = 0.0198.*x-0.1236;
plot(x, f, '-.*', 'MarkerIndices',[902 1336 3016], 'LineWidth', 2); hold on;

ylim([0 70]);

h=text(x(1800) - 10, f(1800) + 2.5, 'hw= 0.0198*n-0.1236');
h.FontSize = 20;
h.FontWeight = 'bold';
h.FontName = 'Times';
set(h, 'Rotation', 36.5);

xlabel('n, channel');
ylabel('Energy, keV');

return;

% [x y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/tube-spectrum.txt');
% 
% plot(x, y, '.-b');
% xlabel('Energy, keV');
% ylabel('Counts, N');
% title('Tungsten tube. 45 degrees, 160 keV');
% 
% return;

%%% crystals

%/home/fna/data/crystals/

files = {
    'ge220_30keV'
    'si100_30keV_prev'
    'si220_30keV'
    'pyro_hor_40_60keV'
    };

displayNames = {
    'Ge (220)'
    'Si (400)'
    'Si (220)'
    'HOPG (0002)'
    };
currentNormalize = ones(4, 1);
currentNormalize(4) = 2;

intensity = zeros(4, 2);

colorIndex = 1;

figure(1);
p = get(gcf, 'position');
p(3) = p(3) * 2;
p(4) = p(4) * 2;
set(gcf, 'position', p);


for i=1:numel(files)
    
    [y] = loadASC(sprintf('/home/fna/105/nitro/new/%s.asc', char(files(i))));
    [y_background] = loadASC(sprintf('/home/fna/105/nitro/new/%s_background.asc', char(files(i))));
    y = (y-y_background) .* currentNormalize(i);
    y_orig = y;
    y = y(750:3500);
    x = 750:3500;
    x = 0.0198.*x-0.1236;

    semilogy(x, y, char(colors(colorIndex)), 'DisplayName', str(char(displayNames(i)))); hold on;
    %plot(x, y, char(colors(colorIndex)), 'DisplayName', str(char(displayNames(i)))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
    
    ax = gca;
    ax.FontSize = 20; 
    ax.FontWeight = 'bold';
    ax.FontName = 'Times';
    ax.LineWidth = 4;

    
    xlabel('Energy, keV');
    ylabel('Counts, N');
    grid on;
    
%     GridStyle.Color     = [0.2, 0.4, 0.1];
%     GridStyle.LineStyle = '-';
%     GridStyle.LineWidth = 2.5;
%     GridStyle.HitTest   = 'off';
%     Child   = get(AxesH, 'Children');         
%     XTick   = get(AxesH, 'XTick');
%     YTick   = get(AxesH, 'YTick');
%     XLimit  = get(AxesH, 'XLim');
%     YLimit  = get(AxesH, 'YLim');
%     newGrid = cat(1, ...
%               line([XTick; XTick], YLimit, 'Parent', AxesH, GridStyle), ...
%               line(XLimit, [YTick; YTick], 'Parent', AxesH, GridStyle));
%     % New grid on top or bottom of other objects: 
%     set(AxesH, 'Child', [newGrid; Child(:)]);    
    
   
    if (i < 4)
        intensity(i, 1) = sum(y_orig(1317:1579));
    else
        intensity(i, 1) = sum(y_orig(1864:2179));
    end
    intensity(i, 2) = sum(y_orig(2808:3206));
end

%xlim([750 3500]);
xlim([14.7264 69.1764]);

ylim([10^0 10^ceil(log10(max(y)))]);
%ylim([10^1 max(y) * 1.1]);

% for 
% g_y=[10^0 10^ceil(log10(max(y)))]; % user defined grid X [start:spaces:end]
% for i=1:length(g_y)
%    plot([14.7264 69.1764],[g_y(i) g_y(i)],'k:','LineWidth', 2) %x grid lines
%    hold on    
% end

% ticksValues = [ 2:floor(log10(max(y))) log10(max(y)) ];
% yticks(ticksValues);
% ticksText2 = {};
% for i = 2:floor(log10(max(y)))
%     ticksText2{end+1} = sprintf('10^{%d}', i);
% end
% ticksText2{end+1} = sprintf('10^{%.1f}', log10(max(y)));
% yticklabels(ticksText2);



lgd = legend('show');
lgd.FontSize = 20;
lgd.FontWeight = 'normal';

return;

figure(2);
p = get(gcf, 'position');
p(3) = p(3) * 2;
p(4) = p(4) * 2;
set(gcf, 'position', p);

c = categorical({str('Ge (220)')
    str('Si (400)')
    str('Si (220)')
    str('HOPG (0002)')});
c = reordercats(c,{str('Ge (220)')
    str('Si (400)')
    str('Si (220)')
    str('HOPG (0002)')});

bar(c, intensity);

ax = gca;
ax.FontSize = 20; 
ax.FontWeight = 'bold';
ax.FontName = 'Times';
ax.LineWidth = 4;


xlabel('Channel');
ylabel('Counts, N');
grid on

l = cell(1,2);
l{1}='1th order'; l{2}='2th order';
lgd = legend(l);
lgd.FontSize = 20;
lgd.FontWeight = 'normal';
ylabel('Intensity');








