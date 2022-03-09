
close all;

number = 0;

fwhmind = 1;

fileIDFWHM = fopen('fwhm.txt','w');
fprintf(fileIDFWHM, 'x y\n');

for e = 41:2:41
    
    if number == 10
         %break;
    end
    
%      fig = figure( 'Name', 'untitled fit 1' );
%      set(fig,'position',[-1280 + mod(10 + number * 638, int32(3200)), 100 + idivide(number, int32(5)) * 500, 600, 400]);
%     
%     if e >= 19
%         ds = dataset('File',sprintf('stats/bias100_tifs_mindiff/txt/m%d.txt', e));
%         dd = double(ds);
%         x = dd(:,1);
%         y = dd(:,2);
%         plot(x, y, '.-b', 'DisplayName', 'bias 100 thl10 (tif min diff)'); hold on;
%     end
    
%     ds = dataset('File',sprintf('stats/bias100/txt/m%d.txt', e));
%     dd = double(ds);
%     x = dd(:,1);
%     y = dd(:,2);
%     plot(x, y, '.-b', 'DisplayName', 'bias 100'); hold on; 
    

%     ds = dataset('File',sprintf('stats/thl5/txt/m%d.txt', e));
%     dd = double(ds);
%     x = dd(:,1);
%     y = dd(:,2);
%     plot(x, y, '.-k', 'DisplayName', 'bias 100 thl5'); hold on;
%     
    r = 0;
    
    
    
    if (e ~= 39)
        
%         ds = dataset('File',sprintf('stats/thl5/txt/e%d.txt', e));
%         dd = double(ds);
%         x = dd(:,1);
%         y = dd(:,2);
%         plot(x, y, '.-g', 'DisplayName', 'bias100 thl5'); hold on;        
        
        ds = dataset('File',sprintf('stats/bias100/txt/e%d.txt', e));
        dd = double(ds);
        x = dd(:,1);
        y = dd(:,2);
         plot(x / 5, y, '.-b', 'DisplayName', 'bias100'); hold on;          
         
        ds = dataset('File',sprintf('stats/bias200/txt/e%d.txt', e));
        dd = double(ds);
        x = dd(:,1);
        y = dd(:,2);
         plot(x / 5, y, '.-r', 'DisplayName', 'bias200'); hold on;  
         
        ds = dataset('File',sprintf('stats/bias50/txt/e%d.txt', e));
        dd = double(ds);
        x = dd(:,1);
        y = dd(:,2);
         plot(x / 5, y, '.-k', 'DisplayName', 'bias50'); hold on;           
        
        ds = dataset('File',sprintf('stats/thl5/txt/e_scatter%d.txt', e));
        dd = double(ds);
        x_scatter = dd(:,1);
        y_scatter = dd(:,2);
%         plot(x_scatter, y_scatter, '.-k', 'DisplayName', 'bias200 thl10 scatter'); hold on;
        
        y_substruct = y;
        for i = 1:size(y, 1)
            for j = 1:size(x_scatter, 1)
                if x_scatter(j) == x(i)
                    y_substruct(i) = y_substruct(i) - y_scatter(j);
                end
            end
        end
        
%         plot(x, y_substruct, '.-m', 'DisplayName', 'bias200 thl10 subsctructed'); hold on;
        
%         axis( [ 1, 1200, 0, 500 ] );        
%         
         r = fwhm(x, y_substruct, e * 10) / 10;
        %r
        
         fwhmX(fwhmind) = e;
         fwhmY(fwhmind) = r;
         fwhmind = fwhmind + 1;
         
         fprintf(fileIDFWHM, '%d %.2f\n', e, r);
        
    end
    
%     ds = dataset('File',sprintf('stats/bias200/txt/m%d.txt', e));
%     dd = double(ds);
%     x = dd(:,1);
%     y = dd(:,2);
%     plot(x, y, '.-r', 'DisplayName', 'bias200 thl10'); hold on;    
    
    
%     legend('show');    
%     title(sprintf('%d kEv fwhm %.2f', e, r));
    
    number = number + 1;
    
    
end

fclose(fileIDFWHM);


%return;

% plot(fwhmX, fwhmY, '.-r', 'DisplayName', 'bias100 thl5'); hold on;    
% title(sprintf('bias 50 FWHM'));
% xlabel('energy');
% ylabel('fwhm');

%axis( [ 1, 60, 0, 50 ] );




