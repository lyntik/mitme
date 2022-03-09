
%%
figure(2);


path = '/home/fna/mounts/bunker/CTmira/150_2_with8.4mmAl';
t = Tiff(sprintf('%s/60000.tif', path) ,'r');
img = read(t);
%figure(1); imshow(mat2gray(img));


%J = imrotate(img, 5);
%imshow(mat2gray(J));
%return;

starty1 = 916;
starty2 = 968;
endy1 = 899;
endy2 = 1022;
cols=124:524;
slope1 = (endy1-starty1)/(cols(end)-cols(1));
slope2 = (endy2-starty2)/(cols(end)-cols(1));

%load(sprintf('%d', 40000));

startcol = cols(1);

% % 
col = 130;

profile = img;
profile = profile(starty1+round((col-startcol)*slope1):starty2+round((col-startcol)*slope2), col);

out = extrems(double(profile));

plot(1:numel(profile), profile, '.-b'); hold on;
plot(out.maxx,out.maxy,'r*'); hold on;
plot(out.minx,out.miny,'k*'); hold on;
%numel(maxx)imshow(mat2gray(imgs(:, :, 2)));

[mtfs] = calcMTFs(double(profile), 0, 11);
min(mtfs)



% %imshow(mat2gray(imgs(:, :, 1)));imshow(mat2gray(imgs(:, :, 1)));
% imshow(mat2gray(img2(70:186, :)));

%%

figure(2);

colorIndex_ = 1;

for axe1=[0 10000 20000 30000 40000 50000 60000]
%for axe1=[60000]
    
   
    load(sprintf('%d', axe1));
    %t = Tiff(sprintf('%s/%d.tif', path, axe1) ,'r');
    %img = read(t);
    
    %mtfs = zeros(numel(cols), 1);
    mtfs = zeros(1000, 1);
    for col=cols
        profile = img(starty1+round((col-startcol)*slope1):starty2+round((col-startcol)*slope2), col);
        [r] = calcMTFs(double(profile), 0.05, 11);
        %mtfs(col-cols(1)+1) = min(r);
        mtfs(col) = min(r);
    end
        
    mtfs(mtfs < 0) = 0;
    r = zeros(7, 1);
    for i=0:4
        r(:) = r(:) + mtfs(ticks(1:end)+i);
    end
    r(:) = r(:)./5;
    %ticks(1:end) = ticks(1:end)-2;
    plot(1:7, r(:), char(colors(colorIndex_)), 'DisplayName', sprintf('M%.2f', 620/(620-40-axe1*0.0025))); hold on;
    
    %plot(cols, mtfs, char(colors(colorIndex))); hold on;
    
    colorIndex_ = colorIndex_ + 1;
    if (colorIndex_ == 8)
        colorIndex_ = 1;
    end
end



legend('show');

%ticks = [cols(1) 174 245 291 350 426 cols(end)];
%xticks(ticks);
xticklabels(num2cell(fix(1000 ./ ([7 6 5 4.5 4 3.5 3].*2))));
xlabel('um');
ylabel('MTF');
legend('show');
title('TDI spatial resolution for mira phantom. mira only');



