



figure(2);

set(gcf,'position',[10,10,1200,800])

path = '/home/fna/share/TDI/mira/scan';

colorIndex = 1;

% exps = {'static'
%     'tdi-245px'
%     'tdi-50px'
%     'tdi-25px'
%     };


exps = {
    'static'
    'img245'
    'img50'
    'img25'
    };

% 130keV_200mkA_0.2s_1.428over_70step.s
% row = [104 40 41 41];
% x1 = [67 958 810 848];

% 130keV_200mkA_0.125s_1.6over_100step.s
row = [105 55 55 55];
x1 = [68 573 573 573];
x2 = x1+40;
w = [256 1101 1101 1101];
h = [256 100 100 100];

% 130keV_200mkA_0.07s_1.9over_140step.s
% row = [105 55 55 55];
% x1 = [68 620 620 620];
% x2 = x1+40;
% w = [256 1101 1101 1101];
% h = [256 100 100 100];


mtf = zeros(4, 1);

subplot(2,1,1);
for expInd=1:numel(exps)

    [img] = loadTXTMatrix(sprintf('%s/%s.txt', path, char(exps(expInd))), w(expInd), h(expInd));
    
    profile = img(row(expInd), x1(expInd):x2(expInd));
    
     if (expInd == 1)
         profile = profile ./ 4;
     end
    
    plot(1:41, profile, char(colors(colorIndex)), 'DisplayName', char(exps(expInd))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end        
    
    mtf(expInd) = abs(profile(18)-profile(15)) / ((profile(18)+profile(15))/2);
    
end

%ylim([0 inf]);
title('ROI Profile (70ms)');
legend('show');

subplot(2,1,2);
plot(1:4, mtf.*100, '.-b');
title('ROI MTF');
set(gca,'xtick', [1:4], 'xticklabel',exps);
ylabel('%');


print -clipboard -dbitmap


