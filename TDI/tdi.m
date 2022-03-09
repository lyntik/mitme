
% [img] = loadTXTMatrix('/home/fna/share/TDI4/mira+rotor/static-large.txt', 256, 256);

% [img] = loadTXTMatrix('/home/fna/share/TDI4/mira/static-large.txt', 256, 256);
% [img] = loadTXTMatrix('/home/fna/share/TDI4/mira/scan/tdi0000.txt', 256, 256);

% % [img] = loadTXTMatrix('/home/fna/share/TDI/static.txt', 256, 256);
% %  
% 
% imshow(mat2gray(img))
% % img=img(50:150, :);
% % imshow(mat2gray(img))
% % imwrite(mat2gray(img2), 'static.tif','tiff');
% 
% figure(2);
% img1=flip(img, 2);
% img2 = img;
% imshow(mat2gray(img2));
% return;

path = '/home/fna/share/TDI4/mira+rotor/scan';

%pixs = [25 50 245];
pixs = [16 32 64 128 245];

%pixs = [32 64 245];

x1 = 10;
x2 = 900;
shots = 1000;

%imgs = zeros(100, x2-x1+1, numel(pixs));
imgs = zeros(116, x2-x1+1, numel(pixs));

imgInd = 1;
for pix = pixs

    %img = zeros(100, pix+shots-1);
    img = zeros(116, pix+shots-1);

    for proj=0:shots-1

        ds = dataset('File', sprintf('%s/tdi%04d.txt', path, proj));
        cellArray = cellstr(ds);

        %for y = 50:149
        %for y = 75:174
        for y = 100:215
            str = char(cellArray(y));

            C = char(strsplit(str, ' '));

            dd = zeros(pix, 1);
            start = fix(125-pix/2);
            for i = start:start+pix-1
                dd(i-start+1) = str2double(C(i, :));
            end

            %img(y-49, proj+1:proj+1+pix-1) = img(y-49, proj+1:proj+1+pix-1) + dd';
            %img(y-74, proj+1:proj+1+pix-1) = img(y-74, proj+1:proj+1+pix-1) + dd';
            img(y-99, proj+1:proj+1+pix-1) = img(y-99, proj+1:proj+1+pix-1) + dd';
        end

    end

    %imshow(mat2gray(img(:, 170:1500)))
    %imshow(mat2gray(img(:, :)))


%     if (pix == 25)
%         img = img(:, x1:x2);
%         img25 = img;
%     elseif (pix == 50)
%         img = img(:, x1+12:x2+12);
%         img = img ./ 2;
%         img50 = img;
%     elseif (pix == 245)
%         img = img(:, x1+110:x2+110);
%         img = img ./ 9.8;
%         img245 = img;
%     end
    plus = (pix-16)/2;
    img = img(:, x1+plus:x2+plus);
    img = img ./ (pix/16);
    
    imgs(:, :, imgInd) = img;
    imgInd = imgInd + 1;
    
    fileID = fopen(sprintf('img%d.txt', pix), 'w');
    for i=1:size(img, 1)
        for j=1:size(img, 2)
            fprintf(fileID,'%.2f ', img(i, j));
        end
        fprintf(fileID,'\n');
    end
    fclose(fileID);


end

return;



% min_set = min(img245(:));
% max_set = max(img245(:));
% 
% % norm
% 
% img25(img25 < min_set) = min_set;
% img50(img50 < min_set) = min_set;
% img245(img245 < min_set) = min_set;
% img25(img25 > max_set) = max_set;
% img50(img50 > max_set) = max_set;
% img245(img245 > max_set) = max_set;

img = imgs(end);
min_set = min(img(:));
max_set = max(img(:));

return;

imgInd = 1;
for pix = pixs
    imwrite(mat2gray(imgs(:, :, imgInd)), sprintf('tdi-%dpx.tif', pix),'tiff');  
    imgInd = imgInd + 1;
end
    
% imwrite(mat2gray(img25), sprintf('tdi-%dpx.tif', 25),'tiff');
% imwrite(mat2gray(img50), sprintf('tdi-%dpx.tif', 50),'tiff');
% imwrite(mat2gray(img245), sprintf('tdi-%dpx.tif', 245),'tiff');



return;


