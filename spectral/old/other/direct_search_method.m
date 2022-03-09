
% [X,Y] = meshgrid(1:0.5:10,1:2:10);
% Z = sin(X) + cos(Y);
% surf(X,Y,Z)
% 
% return;

figure(2);

atts = [];


% YY = [22.37 179.2 363.1 590.3 781 941 1080 1200 1232 1215 1170 1108 984.5 772.9 496.1 77.2 0];
% 
% INC = [ zeros(1, 11) YY zeros(1, 9) ]';

MATERIALS = {'al', 'kih20'};

ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(1))));
dd = double(ds);
atts(:,:) = dd(:,:);
atts = atts(19:42, :);

for i=2:size(MATERIALS, 2)
    ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(i))));
    dd = double(ds);
    atts(:,:,i) = dd(19:42, :);    
end


plot(19:42, atts(:,2,1), '.-b', 'DisplayName', 'Al'); hold on;
plot(19:42, atts(:,2,2), '.-r', 'DisplayName', 'kih20'); hold on;
xlabel('Energy, kEv');
ylabel('Linear absorption coefficient, cm^-1');
legend('show');
return;

ATT = permute(atts(:, 2, :), [3, 1, 2]);

Rij = zeros(26, 24);
for j = 19:42
    Rij(:, j - 18) = piecewiseBuild(j);
end

%%% simul

LI = [ 0.2; 0.05 ];
ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
DEPOS = ATTEDINC' * Rij';

poly = DEPOS(2:26);
poly = sum(reshape(poly, 5, 5), 1);


%INC = INC1;
%INC = INC / (70 * 150);


%%% haha. simul
% LI = [0.5; ];
% ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
% DEPOS = ATTEDINC' * Rij';
% DEPOS = DEPOS(1:25);
% DETBINS(:, 1) = sum(reshape(DEPOS, 5, 5), 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% 2d - 1 component
% 
% component_search = 0:0.0001:0.7;
% 
% X = component_search;
% 
% Y = zeros(size(component_search, 2), 1);
% 
% 
% MINTHICK = 1000;
% MAXTHICK = 0;
% 
% for b = 1:4
%     i = 1;
%     
%     min = 1000;
%     minthick = 0;
% 
%     
%     for LI = component_search
%         ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
%         DEPOS = ATTEDINC' * Rij';
%         %DEPOS = DEPOS(2:26);
%         
% 
% 
% %         if (LI ==  0.5001)
% %             plot(14:50, INC, '.-b'); hold on;
% %             plot(14:50, ATTEDINC, '.-r'); hold on;
% %             plot(14:50, MDE, '.-k'); hold on;
% %             
% %             DEPOS5 = DEPOS;
% %             
% %             pause();
% %         end
% 
%         DEPOS = DEPOS(2:26);
%         
%         LAMBDA = sum(reshape(DEPOS, 5, 5), 1)';
% 
%         %disp();
% 
%         %measurements = size(DETBINS, 2);
%         f = 0.0;
%         %for measure = 1:measurements
%             for bin = b:b
%                 %abs(LAMBDA(bin) - DETBINS(bin, measure))
%                 %f = f + abs(LAMBDA(bin) - DETBINS(bin, measure));
%                 %Z(i2, i1) = abs(LAMBDA(bin) - DETBINS(bin, measure));
%                 %Y(i) = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
%                 %Y(i) = abs(LAMBDA(bin) - DETBINS(bin, measure));
%                 Y(i) = abs(LAMBDA(bin) - poly(bin));
%                 %f = f + (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
%                 
%                 if (Y(i) < min)
%                     min = Y(i);
%                     minthick = LI;
%                     
%                 end
%                 
%             end
%         %end        
%         
%         i = i + 1;
%     end
%     
%     if (MINTHICK > minthick) MINTHICK = minthick; end
%     if (MAXTHICK < minthick) MAXTHICK = minthick; end
%     
%     disp(sprintf('minthick %.3f', minthick));
%     
%     plot(X, Y, '.-b');
%     
%     title(sprintf('%d bin - straight', b));
%     
%     %pause();
%     
%     print(sprintf('plots/straight_%04d', b), '-dpng');
%     
%     close all;
% end
% 
% 
% 
% disp(sprintf('deviation %.3f', MAXTHICK - MINTHICK));
% 
% return;

%%%%% 3d - 2 components
% %alum_search = 0.19:0.0001:0.21;
alum_search = 0.15:0.0001:0.3;
cu_search = 0.000:0.0001:0.07;

[X,Y] = meshgrid(cu_search,alum_search);
Z = zeros(size(X, 1), size(X, 2));

DISCRIM = ones(size(alum_search, 2), 1) * 10000;
DISCRIM_PER = ones(size(alum_search, 2), 1) * 10000;


for b = 3:3
    
    i1 = 1;
    i2 = 1;

    for X1 = alum_search
        i2 = 1;
        for X2 = cu_search
    % 
             LI = zeros(2, 1);
    %         X(1) = 0.198;
    %         X(2) = 0.032;
    % 
    %         % X(1) = 0.3475;
    %         % X(2) = 0.02784;

            LI(1) = X1;
            LI(2) = X2;

            n = size(INC, 1);

            % ATT
            % n
            % repmat(X, 1, n)
            % exp(-(ATT .* repmat(X, 1, n)))
            % 
            % GY = [1 2; 3 3; 4 4;];
            % prod(GY , 1)
            % 
            % return;

            ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, n))), 1)';
            DEPOS = ATTEDINC' * Rij';
            %DEPOS = DEPOS(2:26);

            DEPOS = DEPOS(2:26);
            LAMBDA = sum(reshape(DEPOS, 5, 5), 1)';


            %disp();

            %measurements = size(DETBINS, 2);
            f = 0.0;
            value = 0;
            percent = 0;
            %for measure = 1:measurements
                for bin = b:b
                    %abs(LAMBDA(bin) - DETBINS(bin, measure))
                    %f = f + abs(LAMBDA(bin) - DETBINS(bin, measure));
                    
                    value = abs(LAMBDA(bin) - poly(bin));
                    
                    if (LAMBDA(bin) > poly(bin))
                        percent = (LAMBDA(bin) / poly(bin)) - 1;
                    else
                        percent = (poly(bin) / LAMBDA(bin)) - 1;
                    end
                    %value = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
                    
                    Z(i2, i1) = value;
                    
                    %Z(i2, i1) = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
                    %f = f + (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
                end
            %end

            %disp(sprintf('%.6f', f));

            i2 = i2 + 1;
            
            
            if (value < DISCRIM(i1))
                DISCRIM(i1) = value;
            end
            
            if (percent < DISCRIM_PER(i1))
                DISCRIM_PER(i1) = percent;
            end 

        end        

        i1 = i1 + 1;
    end
    
    
    plot(alum_search, DISCRIM_PER, '.-b');
    return;
    
    
    b
    
    surf(X,Y,Z, 'EdgeColor', 'none', 'FaceAlpha',0.7);
    colorbar;

    title(sprintf('%d bin - straight', b));
    %print(sprintf('plots/straight_%04d', b), '-dpng');
    
    %close all;
    
    
end






