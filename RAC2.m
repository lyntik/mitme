
% xx = zeros(size(gr));
% for y=1:size(gr, 1)
%     xx(y, :) = 1:1200;
% end
% yy = zeros(size(gr));
% for x=1:size(gr, 2)
%     yy(:, x) = 1:100;
% end
% 
% plot3(xx, yy, ind);
% 
% return;
% 
% A = [1 1 1; 5 5 5; 2 2 2];
% r = medianFilter(A, 1, 2);
% 
% return;


path = 'c:/scans/22593-22596';
%img = loadMetaImage('c:/scans/22593-22596/img_.mhd');
%img = permute(img, [2, 1, 3]);
% img = img(1505-50:1505+50, 782:782+1200, :);

%row = 50;
medianSpan = 5;
n = size(img, 2);
append = 15;
grThr = 0.1;
sigma1=0.8;
sigma2=3;
sigma3=10;
subsetSize = 999;
ndim = 2;


for proj1=1:subsetSize:size(img, 3)

    proj2 = min(proj1+subsetSize-1, size(img, 3));
    % coeffs
    coeffs = ones(size(img, 1), size(img, 2));
    
    if ndim==1
        for row=1:size(img, 1)
            sino = sum(img(row, :, proj1:proj2), 3);
            sino1 = medianFilter(sino, medianSpan, 1);

            gr = zeros(numel(sino), 1);
            for x=2:n
                gr(x) = abs(sino1(x) - sino1(x-1));
            end
            gr = medianFilter(gr, medianSpan, 1);
            gr = gr./max(gr);

            ind = ones(numel(sino), 1).*3;
            ind(gr>0.1)=1;
            for x=append+1:n
                if (ind(x)==1 && ind(x-1)==3)
                    ind(x-append:x-1) = 2;
                end  
            end 
            for x=n-append:-1:1
                if (ind(x)==1 && ind(x+1)==3)
                    ind(x+1:x+append) = 2;
                end  
            end 

            gauss1 = normpdf(-30:30,0,sigma1);
            gauss2 = normpdf(-30:30,0,sigma2);
            gauss3 = normpdf(-30:30,0,sigma3);

            for x=31:n-31
                switch ind(x)
                case 1
                    f = gauss1;
                case 2
                    f = gauss2;
                case 3
                    f = gauss3;
                end
                level = sino(x-30:x+30)*f';
                coeffs(row, x) = level / sino(x);
            end 
        end
    elseif ndim==2 
        sino = sum(img(:, :, proj1:proj2), 3);
        sino1 = medianFilter(sino, medianSpan, 2);
        
%         gr = zeros(size(sino));
%         for row=1:size(img, 1)
%             for x=2:n
%                 gr(row, x) = abs(sino1(row, x) - sino1(row, x-1));
%             end
%         end
        gr = gradient(sino1, 1, 2);
        gr = medianFilter(gr, medianSpan, 2);
        gr = gr./max(gr);        
        
        % xx = zeros(size(gr));
        % for y=1:size(gr, 1)
        %     xx(y, :) = 1:1200;
        % end
        % yy = zeros(size(gr));
        % for x=1:size(gr, 2)
        %     yy(:, x) = 1:100;
        % end
        % 
        % plot3(xx, yy, gr);
        
%         ind = ones(size(sino)).*3;
%         ind(gr>0.1)=1;
%         
%         for row=1:size(sino, 1)
%             for x=append+1:n
%                 if (ind(row, x)==1 && ind(row, x-1)==3)
%                     ind(ind(row, x-append:x-1)==3) = 2;
%                 end  
%             end 
%             for x=n-append:-1:1
%                 if (ind(row, x)==1 && ind(row, x+1)==3)
%                     ind(ind(row, x+1:x+append)==3) = 2;
%                 end  
%             end 
%         end
%         
        
        return;
        
    else
        ME = MException('rac', ...
        'ndim %d is not supported', ndim);
        throw(ME) 
    end

    for proj=proj1:proj2
        tifCorr = zeros(size(img, 1), size(img, 2), 'uint16');
        for row=1:size(img, 1)
            tifCorr(row, :) = round(double(img(row, :, proj)) .* coeffs(row, :));
        end

        t = Tiff(sprintf('%s/corr/img_%04d.tif', path, proj), 'w');
        tagstruct.ImageLength = size(tifCorr,1);
        tagstruct.ImageWidth = size(tifCorr,2);
        tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
        tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
        tagstruct.BitsPerSample = 16;
        tagstruct.SamplesPerPixel = 1;
        tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
        setTag(t,'ResolutionUnit',Tiff.ResolutionUnit.Inch);
        setTag(t,'XResolution',298.82);
        setTag(t,'YResolution',298.82);
        tagstruct.Software = 'MATLAB'; 
        setTag(t,tagstruct);
        write(t,tifCorr);
        close(t);    
    end
end



% sino1 = sino;
% for x=medianSpan+1:n-medianSpan-1
%  sino1(x) = median(sino(x-medianSpan:x+medianSpan));
% end

% plot(1:numel(sino), sino, '.-b'); hold on;
% plot(1:numel(sino), sino1, '.-r'); hold on;
%plot(1:n, ind, '.-r'); hold on;

%plot(1:n, coeffs, '.-r'); hold on;

%plot(1:size(sino, 2), gr(50, :), '.-r'); hold on;
plot(1:size(sino, 2), ind(50, :), '.-r'); hold on;


%imagesc(img(:, :, 1));


