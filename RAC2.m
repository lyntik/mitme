% 
% sigma1 = 1;
% 
% % mu = [0 0];
% % x1 = -5:5;
% % x2 = -5:5;
% % [X1,X2] = meshgrid(x1,x2);
% % X = [X1(:) X2(:)];
% % gauss1 = mvnpdf(X,mu,eye(2).*sigma1);
% % gauss1 = reshape(gauss1,length(x2),length(x1));
% % gauss1 = gauss1./sum(gauss1(:))
%         
% gaussMy = zeros(size(gauss1));
% for xx1=x1
%     for xx2=x2
%         gaussMy(xx2+6, xx1+6) = exp(-( xx1^2/(2*sigma1^2) + xx2^2/(2*sigma1^2)));
%     end
% end
% gaussMy = gaussMy./sum(gaussMy(:))
% 
% 
% return;


% path = 'c:/scans/kern30/withffc';
% img = loadMetaImage(sprintf('%s/img_.mhd', path));
% img = permute(img, [2, 1, 3]);
%img = img(1684-250:1684+250, :, :);

%row = 50;
medianSpan = 5;
n = size(img, 2);
n1 = size(img, 1);
n2 = size(img, 2);
append = 15;
grThr = 0.1;
sigma1=0.8;
sigma2=3;
sigma3=10;
subsetSize = 600;
ndim = 1;

for proj1=1:subsetSize:size(img, 3)

    proj2 = min(proj1+subsetSize-1, size(img, 3));
    % coeffs
    coeffs = ones(size(img, 1), size(img, 2));
    
    if ndim==1
        for row=1:size(img, 1)
        %for row=50:50
            sino = sum(img(row, :, proj1:proj2), 3);
            sino1 = medianFilter(sino, medianSpan, 1);

            gr = zeros(numel(sino), 1);
            for x=2:n
                gr(x) = abs(sino1(x) - sino1(x-1));
            end
            gr = medianFilter(gr, medianSpan, 1);
            gr = gr./max(gr(:));
            
            ind = ones(numel(sino), 1).*3;
            ind(gr>0.1)=1;
            %ind = appendMiddle(ind, append, 2);
            
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
                        
            gauss1 = normpdf(-10:10,0,sigma1);
            gauss1 = gauss1./sum(gauss1);
            gauss2 = normpdf(-10:10,0,sigma2);
            gauss2 = gauss2./sum(gauss2);
            gauss3 = normpdf(-10:10,0,sigma3);
            gauss3 = gauss3./sum(gauss3);

            for x=11:n-10
                switch ind(x)
                case 1
                    f = gauss1;
                case 2
                    f = gauss2;
                case 3
                    f = gauss3;
                end
                level = sino(x-10:x+10)*f';
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
        max(gr(:))
        gr = gr./max(gr(:));
        %gr = gr./138399;
        
        
%         xx = zeros(size(gr));
%         for y=1:size(gr, 1)
%             xx(y, :) = 1:1200;
%         end
%         yy = zeros(size(gr));
%         for x=1:size(gr, 2)
%             yy(:, x) = 1:100;
%         end
%         
%         plot3(xx, yy, gr);
        
%         ind = ones(size(sino)).*3;
%         ind(gr>0.1)=1;
%         
%         for row=1:size(sino, 1)
%             for x=append+1:n
%                 if (ind(row, x)==1 && ind(row, x-1)==3)
%                     ind(ind(row, x-append:x-1)==3) = 2;
%                 end  
%             end 
%              for x=n-append:-1:1
%                 if (ind(row, x)==1 && ind(row, x+1)==3)
%                     ind(ind(row, x+1:x+append)==3) = 2;
%                 end  
%             end 
%         end
        ind = ones(size(sino)).*3;
        ind(gr>0.1)=1;
        ind = appendMiddle(ind, append, 2);
        
        mu = [0 0];
        x1 = -5:5;
        x2 = -5:5;
        [X1,X2] = meshgrid(x1,x2);
        X = [X1(:) X2(:)];
        gauss1 = mvnpdf(X,mu,eye(2).*sigma1);
        gauss1 = reshape(gauss1,length(x2),length(x1));
        gauss1 = gauss1./sum(gauss1(:));
        gauss2 = mvnpdf(X,mu,eye(2).*sigma2);
        gauss2 = reshape(gauss2,length(x2),length(x1));
        gauss2 = gauss2./sum(gauss2(:));
        gauss3 = mvnpdf(X,mu,eye(2).*sigma3);
        gauss3 = reshape(gauss3,length(x2),length(x1));
        gauss3 = gauss3./sum(gauss3(:));
        
        for i1=11:n1-5
            for i2=11:n2-5
                switch ind(i1, i2)
                case 1
                    f = gauss1;
                case 2
                    f = gauss2;
                case 3
                    f = gauss3;
                end
                level = sino(i1-5:i1+5, i2-5:i2+5).*f;
                coeffs(i1, i2) = sum(level(:)) / sino(i1, i2);
            end
        end
        
        %return;
    else
        ME = MException('rac', ...
        'ndim %d is not supported', ndim);
        throw(ME) 
    end
    
    thr1 = 0.7;
    thr2 = 0.7;
    
    coeffsInd = (coeffs > (100+thr1)/100)|(coeffs < (100-thr2)/100);
    
    %return;
        
%      for i1=1:n1
%          for i2=1:n2
%              if (coeffsInd(i1, i2) == 1)
%                  around = coeffsInd(i1-1:i1+1, i2-1:i2+1);
%                  if (sum(around(:)) > 3)
%                      if (coeffs(i1, i2) > (100+thr1)/100)
%                          coeffs(i1, i2) = (100+thr1)/100;
%                      else
%                          coeffs(i1, i2) = (100-thr2)/100;
%                      end
%                  end
%              end
%          end
%      end        

     for i1=3:n1-2
         for i2=3:n2-2
             if (coeffsInd(i1, i2) == 1)
                 around = coeffsInd(i1-2:i1+2, i2-2:i2+2);
                 if (sum(around(:)) > 13)
                     if (coeffs(i1, i2) > (100+thr1)/100)
                         coeffs(i1, i2) = (100+thr1)/100;
                     else
                         coeffs(i1, i2) = (100-thr2)/100;
                     end
                     %coeffs(i1, i2) = reduceCoeff(coeffs(i1, i2), 1.5);
                 end
             end
         end
     end        

%      s = size(coeffsInd);
% % 
%     around = 3;
%     for i1=around+1:n1-around
%         for i2=around+1:n2-around
%             if (coeffsInd(i1, i2) == 1)
%                 select = coeffs(i1-around:i1+around, i2-around:i2+around);
%                 s(i1, i2) = std(select(:));
%                 if (s(i1, i2) > 0.005)
% %                 if (std(around(:)) > 3)
%                     if (coeffs(i1, i2) > (100+thr1)/100)
%                      coeffs(i1, i2) = (100+thr1)/100;
%                     else
%                      coeffs(i1, i2) = (100-thr2)/100;
%                     end
%                 end
%             end
%         end
%     end  
    
    
    %plot(1:size(s, 2), s(60, :), '.-b');
    
    %return;

    
%     coeffs(coeffs > (100+thr1)/100) = (100+thr1)/100;
%     coeffs(coeffs < (100-thr2)/100) = (100-thr2)/100;
    %coeffs(coeffs < (100-thr2)/100) = coeffs(coeffs < (100-thr2)/100) = (100-thr2) ;
    
%     plot(1:n, coeffs(1764, :), '.-r'); hold on;
%     return;
% 
    for proj=proj1:proj2
        tifCorr = zeros(size(img, 1), size(img, 2), 'uint16');
        for row=1:size(img, 1)
            tifCorr(row, :) = round(double(img(row, :, proj)) .* coeffs(row, :));
        end

        t = Tiff(sprintf('%s/corr1d/img_%04d.tif', path, proj), 'w');
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

%plot(1:numel(sino), sino1, '.-r'); hold on;
%plot(1:n, ind, '.-r'); hold on;

%plot(1:n, coeffs(), '.-r'); hold on;

%plot(1:size(sino, 2), sino1(50, :), '.-b'); hold on;
%plot(1:size(sino, 2), gr(51, :), '.-r'); hold on;
%plot(1:size(sino, 2), ind(50, :), '.-b'); hold on;


%imagesc(img(:, :, 1));


