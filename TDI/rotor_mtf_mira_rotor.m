
startcol = 135;
starty1 = 28;
starty2 = 72;
slope = 12.36;
% 
% col = 367;
% 
% profile = imgs(:, col, imgInd);
% profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
% 
% out = extrems(profile);
% 
% plot(1:numel(profile), profile, '.-b'); hold on;
% plot(out.maxx,out.maxy,'r*'); hold on;
% %numel(maxx)
% 
% [mtfs] = calcMTFs(profile, thr, 11);
% min(mtfs)
% 
% return;

%imshow(mat2gray(imgs(:, :, 5)));
%imshow(mat2gray(img2));
%imshow(mat2gray(imgs(:, :, 5)));


% mira+rotor

cols=135:370;
%cols=300;


figure(2);

colorIndex = 1;

for imgInd=[3 4 5] %1:numel(pixs)
    mtfs = zeros(numel(cols), 1);
    for col=cols
        profile = imgs(:, col, imgInd);
        profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
        [r] = calcMTFs(profile, 0.05, 11);
        mtfs(col-cols(1)+1) = min(r);
    end
        
    plot(cols, mtfs, char(colors(colorIndex)), 'DisplayName', sprintf('%d cols', pixs(imgInd))); hold on;
    
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end

end

legend('show');

xticks([135 184 218 254 308 376]);
xticklabels(num2cell(fix(1000 ./ ([6 5 4.5 4 3.5 3].*2))));
xlabel('um');
ylabel('MTF');
legend('show');
title('TDI contrast. mira+rotor');

 

startcol = 120;
starty1 = 137;
starty2 = 180;
slope = 12.1;

cols=120:242;
% mtfs = zeros(numel(cols), 1);
% for col=cols
%     profile = img1(:, col);
%     profile = profile(starty1-round((col-startcol)/slope):starty2+round((col-startcol)/slope));
% %     plot(1:numel(profile), profile, '.-b');
% %     return;
%     [r] = calcMTFs(profile, 0.05, 11);
%     mtfs(col-cols(1)+1) = min(r);
% end
% plot(cols+15, mtfs, char(colors(colorIndex)), 'DisplayName', 'static small'); hold on;
% % 
% 
% return;


starty1 = 130;
starty2 = 172;
slope = 12.1;

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
plot(cols+15, mtfs, char(colors(colorIndex)), 'DisplayName', 'static'); hold on;

return;

% xticks([123 169 199 244]);
% xticklabels(num2cell(fix(1000 ./ ([6 5 4.5 4 ].*2))));
% xlabel('um');
% ylabel('MTF');
% legend('show');
% title('TDI spatial resolution for mira phantom. mira+rotor');


return;


