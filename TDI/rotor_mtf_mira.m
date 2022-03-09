
startcol = 145;
starty1 = 27;
starty2 = 60;
slope = 12.8;
% % 
% col = 290;
% 
% profile = imgs(:, col, 5);
% profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
% 
% out = extrems(profile);
% 
% plot(1:numel(profile), profile, '.-b'); hold on;
% plot(out.maxx,out.maxy,'r*'); hold on;
% %numel(maxx)imshow(mat2gray(imgs(:, :, 2)));
% 
% [mtfs] = calcMTFs(profile, thr, 11);
% min(mtfs)
% 
% return;
% 
% %imshow(mat2gray(imgs(:, :, 1)));imshow(mat2gray(imgs(:, :, 1)));
% imshow(mat2gray(img2(70:186, :)));


% mira

cols=145:325;
%cols=300;


figure(2);

colorIndex = 1;

for imgInd=3:3
    mtfs = zeros(numel(cols), 1);
    for col=cols
        profile = imgs(:, col, imgInd);
        profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
        [r] = calcMTFs(profile, 0.05, 11);
        mtfs(col-cols(1)+1) = min(r);
    end
        
    plot(cols, mtfs, char(colors(colorIndex)), 'DisplayName', sprintf('%d pixs', pixs(imgInd))); hold on;
    
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end

end

legend('show');

xticks([145 172 206 250 282 321]);
xticklabels(num2cell(fix(1000 ./ ([8 7 6 5 4.5 4].*2))));
xlabel('um');
ylabel('MTF');
legend('show');
title('TDI spatial resolution for mira phantom. mira only');

startcol = 60;
starty1 = 106;
starty2 = 144;
slope = 12.8;

cols=60:242;
mtfs = zeros(numel(cols), 1);
for col=cols
    profile = img1(:, col);
    profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
%     plot(1:numel(profile), profile, '.-b');
%     return;
    [r] = calcMTFs(profile, 0.05, 11);
    mtfs(col-cols(1)+1) = min(r);
end
plot(cols+85, mtfs, char(colors(colorIndex)), 'DisplayName', 'static small'); hold on;
% 


startcol = 60;
starty1 = 101;
starty2 = 136;
slope = 12.8;

colorIndex = colorIndex + 1;
mtfs = zeros(numel(cols), 1);
for col=cols
    profile = img2(:, col);
    profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
%     plot(1:numel(profile), profile, '.-b');
%     return;
    [r] = calcMTFs(profile, 0.05, 11);
    mtfs(col-cols(1)+1) = min(r);
end
plot(cols+85, mtfs, char(colors(colorIndex)), 'DisplayName', 'static large'); hold on;


% xticks([123 169 199 244]);
% xticklabels(num2cell(fix(1000 ./ ([6 5 4.5 4 ].*2))));
% xlabel('um');
% ylabel('MTF');
% legend('show');
% title('TDI spatial resolution for mira phantom. mira+rotor');


return;





