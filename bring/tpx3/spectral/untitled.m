

%%

figure(2);
for cl=2:4
%for cl=0
  
    subplot(2,3,cl-1);
    %subplot(2,1,1);

    [x y] = loadXY(sprintf('/home/fna/dev/createtiff/build/spectrum_%d_120.txt', cl));
    plot(x(1:80), y*1, '.-b', 'DisplayName', 'almost direct'); hold on;
    I0 = sum(reshape(y, [10, 8]));
    m = [60 ];
    mu = zeros(numel(m), 8);
    index = 1;

    colorIndex = 2;
    for i = m
        [x y] = loadXY(sprintf('/home/fna/dev/createtiff/build/spectrum_%d_%d.txt', cl, i));
        plot(x(1:80), y*1, char(colors(colorIndex)), 'DisplayName', sprintf('%d', i)); hold on;
        colorIndex = colorIndex + 1;
        y = sum(reshape(y, [10, 8]));
        mu(index, :) = log(I0 ./ y);
        index = index + 1;
    end
    xticks(10:10:80);
    
    
    
    title(sprintf('%d cluster', cl));
    %slegend('show');

    subplot(2,3,(cl-1)+3);
    %subplot(2,1,2);
    colorIndex = 1;
    for i=1:numel(m)
        plot(2:7, mu(i, 2:7), char(colors(colorIndex))); hold on;
        colorIndex = colorIndex + 1;
    end
    xticks(1:8);
    
end

suptitle({'phantom gd\_3\_1500'});



%%  

% ki = zeros(6, 1);
% gd = zeros(6, 1);
% h2o = zeros(6, 1);
% 
% for i = 0:5
%      [raw] = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/fdk%d.mha', i));
%     
%      %plot(1:128, raw(40, :, 70), char(colors(colorIndex)), 'DisplayName', sprintf('%d', i)); hold on;
%      %return;
%      ki(i+1) = sum(sum(sum(raw(45:55, 35:45, 65:75), 1), 2), 3)/numel(raw(45:55, 35:50, 65:75));
%      gd(i+1) = sum(sum(sum(raw(30:40, 80:90, 65:75)), 2) ,3)/numel(raw(30:40, 80:90, 65:75));
%      h2o(i+1) = sum(sum(sum(raw(85:95, 70:80, 65:75)), 2) ,3)/numel(raw(85:95, 70:80, 65:75));
% end
% 
% plot(1:6, ki, '.-r'); hold on;
% plot(1:6, gd, '.-g'); hold on;
% plot(1:6, h2o, '.-b'); hold on;


[raw] = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/fdk%d.mha', 0));
n = numel(raw(45:55, 35:45, 65:75));

mu = zeros(6, 3);

for bin=1:6
    raw = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/fdk%d.mha', bin-1));
   
    mu(bin, 1) = sum(sum(sum(raw(45:55, 35:45, 65:75), 1), 2), 3)/n;
    mu(bin, 2) = sum(sum(sum(raw(30:40, 80:90, 65:75), 1), 2), 3)/n;
    mu(bin, 3) = sum(sum(sum(raw(85:95, 70:80, 65:75), 1), 2), 3)/n;
end
% 
displayNames = {
    'KI'
    'Gd'
    'PMMA'
    };

colorIndex = 1;
for m=1:3
    plot(1:6, mu(:, m), char(colors(colorIndex)), 'DisplayName', str(char(displayNames(m)))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
% 
% mats = zeros(128, 128, 3);
% 
% slices = zeros(128, 128, 6);
% for bin=1:6
%     raw = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/fdk%d.mha',bin-1));
%     slices(:, :, bin) = raw(:, :, 78);
% end
% 
% A = [mu; 1 1 1];
% for x=1:128
%     for z=1:128
%         b = ones(7, 1);
%         b(1:6) = slices(z, x, :);
%         mats(z, x, :) = lsqnonneg(A,b,[],1000);
%     end
% end
% 
% figure(1);
% image(flip(mats(:, :, 1)) , 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('SiO2');
% figure(2);
% image(flip(mats(:, :, 2)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('CaCO3');
% figure(3);
% image(flip(mats(:, :, 3)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('FeS2');
% 





