
% 
% 1 cluster
% e = [ 8    11  22   25    28  43   ]; 
% mean = [ 5  8  19   22    24  37 ];

% 2 cluster
% e = [ 11   22   25   43  59.3 74.9]; 
% mean = [  8 20   23   40   57   72 ];

% 3 cluster
% mean = [   15  18     23   40 58 74 ]; 
% e = [    22  25     28   43  59.3 74.9]; 

 
%  plot(e, mean, '.-b');
% % % 
%  return;

% 
% 
% return;

% 
% colorIndex = 1;
% 
% 
% i = 2;
% 
% [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/50_0.3/Ag/%d.txt', i)); hold on;
% x = x(1:100);
% y = y(1:100)./1;
% 
% 
% plot((x), (y-y_back*0.4), char(colors(colorIndex)), 'DisplayName', sprintf('%d ag', i));
% colorIndex = colorIndex + 1;
% if (colorIndex == 8)
%     colorIndex = 1;
% end 
% 
% 
% 
% [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/50_0.3/Al/%d.txt', i)); hold on;
% x = x(1:100);
% y = y(1:100)./1;
% y_back = y;
% 
% plot((x), (y_back), char(colors(colorIndex)), 'DisplayName', sprintf('%d back', i));
% colorIndex = colorIndex + 1;
% if (colorIndex == 8)
%     colorIndex = 1;
% end 
% 
% return;


% 
% [x y] = loadXY('/home/fna/dev/pixetsdk/whole/0.txt');
% x = x(1:200);
% y = y(1:200);
% plot(x, y, '.-b');

% syms x;
% f(x) = x - 1/(x-4);
% g(x) = finverse(f);
% 
%figure(4);
%figure('Renderer', 'painters', 'Position', [10 10 900 720])
figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)


colorIndex = 1;

exp = '50_0.3';

targets = {
    'Al'
    'Ag'
    'Cu'
    'KI'
    'Pb'
    'Sn'
    
%     'W'
%     'Pb'
%     'Gd'
    };

i = 2;

[x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/XRF/%s/background/%d.txt', exp, i));

x = x(1:50);
y = y(1:50)./1;
y_back = y;
% plot((x), (y), char(colors(colorIndex)), 'DisplayName', sprintf('%d back', i)); hold on;
% colorIndex = colorIndex + 1;
% if (colorIndex == 8)
%     colorIndex = 1;
% end 

ymax = -1;

for t = 1:numel(targets)
    
    [x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/XRF/%s/%s/%d.txt', exp, char(targets(t)), i));
    
    x = x(1:50);
    y = y(1:50);
    

    
%     plot((x), (y), char(colors(colorIndex)), 'DisplayName', sprintf('%s target', char(targets(t)))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end   

    y = y-y_back;
    
%     if (t == 5) 
%         y(1:13) = 0; 
%         
%     end    
%     
    y = y./sum(y);
    
%     if (t == 5) 
%         y = y .* 1.1;
%     end
    
    ymax = max(ymax, max(y));
    plot((x), (y), char(colors(colorIndex)), 'DisplayName', sprintf('%s target', char(targets(t))));  hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end   
    
end

ylim([0 ymax + ymax * 0.05]);

xlabel('TOT');
ylabel('Intensity, %');
%title(sprintf('XRF. %d cluster. high energy', i));
legend('show');
print('-clipboard','-dbitmap');

% y_back = y_back./sum(y_back);
% plot((x), (y_back), char(colors(colorIndex)), 'DisplayName', sprintf('%d back', i)); hold on;
% colorIndex = colorIndex + 1;
% if (colorIndex == 8)
%     colorIndex = 1;
% end 





%[x y] = loadXY('/home/fna/dev/pixetsdk/2.txt'); hold on;

return;



