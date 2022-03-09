%%

% Point structure

%%
% 
% 
% slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/ref2.mha');
% slice=permute(slice(250, :, :), [3 2 1]);
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(51, 180:220) = 1;
% profile = slice(ind);
% plot(1:numel(profile), profile, '.-b', 'DisplayName', 'ref'); hold on;
% 
% slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk2.mha');
% slice=permute(slice(250, :, :), [3 2 1]);
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(51, 180:220) = 1;
% profile = slice(ind);
% plot(1:numel(profile), profile, '.-r', 'DisplayName', 'ideal geom'); hold on;
% 
% 
% slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-1voxAlongX.mha');
% slice=permute(slice(250, :, :), [3 2 1]);
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(51, 180:220) = 1;
% profile = slice(ind);
% plot(1:numel(profile), profile, '.-k', 'DisplayName', '1 vox'); hold on;
% 
% slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-2voxAlongX.mha');
% slice=permute(slice(250, :, :), [3 2 1]);
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(51, 180:220) = 1;
% profile = slice(ind);
% plot(1:numel(profile), profile, '.-g', 'DisplayName', '2 vox'); hold on;

% return;
% 
x = 200;

slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/ref2.mha');
slice=permute(slice(250, :, :), [3 2 1]);
ind = zeros(size(slice, 1), size(slice, 2), 'logical');
ind(20:60, x) = 1;
profile = slice(ind);
plot(1:numel(profile), profile, '.-b', 'DisplayName', 'ref'); hold on;

slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk2.mha');
slice=permute(slice(250, :, :), [3 2 1]);
ind = zeros(size(slice, 1), size(slice, 2), 'logical');
ind(20:60, x) = 1;
profile = slice(ind);
plot(1:numel(profile), profile, '.-r', 'DisplayName', 'ideal geom'); hold on;

slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-1voxAlongX.mha');
slice=permute(slice(250, :, :), [3 2 1]);
ind = zeros(size(slice, 1), size(slice, 2), 'logical');
ind(20:60, x) = 1;
profile = slice(ind);
plot(1:numel(profile), profile, '.-k', 'DisplayName', '1 vox'); hold on;

slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-2voxAlongX.mha');
slice=permute(slice(250, :, :), [3 2 1]);
ind = zeros(size(slice, 1), size(slice, 2), 'logical');
ind(20:60, x) = 1;
profile = slice(ind);
plot(1:numel(profile), profile, '.-g', 'DisplayName', '2 vox'); hold on;
% 

xlabel('Pix');
ylabel('Linear Attenuation Coefficient');
legend('show');
%imagesc(slice);
% 
% 
return;

% KERN

mtfs = zeros(4, 1);

% imagesc(slice)
% 
% % ref
% slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/ref.mha');
% slice = slice(:, :, 100);
% %slice=permute(slice(516, :, :), [3 2 1]);
% 
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(499, 957:967) = 1;
% %ind(501, 454:464) = 1;
% %ind(95:106, 609) = 1;
% profile = slice(ind);
% plot(1:numel(profile), profile, '.-b', 'DisplayName', 'ref'); hold on;
% base = min(profile);
% 
% mtfs(1) = mtf(profile, base);


% no offset X
slice = loadMetaImage('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk100.mha');
%slice = slice(:, :, 10);
slice=permute(slice(516, :, :), [3 2 1]);
s = slice(50-30:50+29, 609-30:609+29);
ind = zeros(size(s, 1), size(s, 2), 'logical');
ind(1:45, 32) = 1;
profile = s(ind);
plot(1:numel(profile), profile, '.-r', 'DisplayName', 'ideal geom'); hold on;
mtfs(2-1) = mtf2(profile, base, 28, 32, 30);

%return;

% 
% figure(3);
% colormap gray;
% %s = slice(470:520, 940:990);
% s = slice(50-30:50+29, 609-30:609+29);
% hImg = imagesc(s);
% xlabel('pix');
% ylabel('pix');
% %hline = imdistline(gca, [20 27], [29 29]);
% hline = imdistline(gca, [32 32], [2 45]);
% setLabelTextFormatter(hline, '');


% offsetX
% off = 10;
% slice = loadMetaImage(sprintf('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-%dvoxAlongX.mha', off));
% slice = slice(:, :, 10);


colorIndex = 3;
for off=[1 2 ]
	slice = loadMetaImage(sprintf('/home/fna/src/InsightToolkit-5.1rc03/build/bin/fdk-%dvoxAlongX.mha', off));
    %slice = loadMetaImage(sprintf('/home/fna/mounts/bunker/drift/M5/X/fdk-%dvoxAlongX.mha', off));
    
    %slice = slice(:, :, 10);
    slice=permute(slice(516, :, :), [3 2 1]);
    
    s = slice(50-30:50+29, 609-30:609+29);
    ind = zeros(size(s, 1), size(s, 2), 'logical');
    ind(1:45, 32) = 1;
    
    profile = s(ind);
    plot(1:numel(profile), profile, char(colors(colorIndex)), 'DisplayName', sprintf('offset %.2fmm', off*0.18)); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end         
    
    mtfs(1+off) = mtf2(profile, base, 28, 33, 30);
%     if (off==5)
%         mtfs(2) = mtf2(profile, base, 24, 29, 26);
%     end
%     if (off==10)
%         mtfs(3) = mtf2(profile, base, 20, 24, 22);
%     end
%     if (off==30)
%         mtfs(4) = mtf2(profile, base, 4, 9, 6);
%     end    
    
        
    %mtfs(1+off-1) = mtf(profile, base);

%         mtfs(2+off) = mtf3(profile, base);
%     end
end

xlabel('Pix');
ylabel('Intensity');
title('Profile');
legend('show');
% 

% 

function v = mtf(profile, base)
    I1 = (mean(profile(3:4))+mean(profile(8:9)))/2 - base;
    I2 = profile(6) - base;
    
    v = (I1-I2)/(I1+I2);
end


function v = mtf2(profile, base, ind1, ind2, ind3)
    I1 = (mean(profile(ind1))+mean(profile(ind2)))/2 - base;
    I2 = profile(ind3) - base;
    
    v = (I1-I2)/(I1+I2);
end


% 
% % % % 
% plot(1:numel(mtfs), mtfs.*100, '.-b', 'DisplayName', 'Offset (Edge) Y'); hold on;
% exps={'ideal geom'};
% for i=1:2
%     exps(i+1) = cellstr(sprintf('%.2f mm', i * 0.18));
% end    
% set(gca, 'xtick', 1:numel(mtfs), 'xticklabel', exps);
% xtickangle(45);
% ylabel('MTF, %');
% title('MTF');

% 
% % 
% plot(1:numel(mtfs1), mtfs1.*100, '.-b', 'DisplayName', 'Offset (Edge) X'); hold on;
% exps={'ref', 'ideal geom'};
% for i=1:10
%     exps(i+2) = cellstr(sprintf('%.2f mm', i * 0.18));
% end    
% set(gca, 'xtick', 1:numel(mtfs1), 'xticklabel', exps);
% xtickangle(45);
% ylabel('MTF, %');
% title('MTF');
% 
% plot(1:numel(mtfs2), mtfs2.*100, '.-r', 'DisplayName', 'Drift (Edge)'); hold on;
% exps={'ref', 'ideal geom'};
% for i=1:10
%     exps(i+2) = cellstr(sprintf('%.2f mm', i * 0.18));
% end    
% set(gca, 'xtick', 1:numel(mtfs2), 'xticklabel', exps);
% xtickangle(45);
% ylabel('MTF, %');
% title('MTF');
% 
% plot(1:numel(mtfs3), mtfs3.*100, '.-k', 'DisplayName', 'Offset (Center)'); hold on;
% exps={'ref', 'ideal geom'};
% for i=1:10
%     exps(i+2) = cellstr(sprintf('%.2f mm', i * 0.18));
% end    
% set(gca, 'xtick', 1:numel(mtfs3), 'xticklabel', exps);
% xtickangle(45);
% ylabel('MTF, %');
% title('MTF');
% legend('show');


