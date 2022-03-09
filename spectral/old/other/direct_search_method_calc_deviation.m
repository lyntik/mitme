
function f=direct_search_method_calc_deviation(INC)

blah = 0;



for experiment=1008:1010
    
    
    mins = ones(4, 1) * 100000000000;
    minthicks = ones(4, 1) * 10000;

% [X,Y] = meshgrid(1:0.5:10,1:2:10);
% Z = sin(X) + cos(Y);
% surf(X,Y,Z)
% 
% return;

%figure(2);

atts = [];


MATERIALS = {'al'};
if experiment == 1008
    MATERIALS = {'cu'};
end


ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(1))));
dd = double(ds);
atts(:,:) = dd(:,:);
atts = atts(14:50, :);

for i=2:size(MATERIALS, 2)
    ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(i))));
    dd = double(ds);
    atts(:,:,i) = dd(14:50, :);    
end


ATT = permute(atts(:, 2, :), [3, 1, 2]);


Rij = zeros(37, 37);
for j = 14:50
    Rij(:, j - 13) = piecewiseBuild(j);
end

measurements = 11;


poly_ = zeros(37, measurements);

for measure = 1:measurements
    ds = dataset('File',sprintf('thrafl/%d_%d.txt', experiment, measure - 1));
    dd = double(ds);
    x = dd(:,1)';
    y = dd(:,2)';
    
    poly_(:, measure) = y(1:37);
end

poly_ = poly_ * 1;



poly = zeros(37, 1);
for i = 1:37
    for measure = 1:measurements
        poly(i) = poly(i) + poly_(i, measure);
    end

    poly(i) = poly(i) / measurements;
        
end

poly = poly(1:35);

% ATTEDINC = INC .* prod(exp(-(ATT .* repmat(0.032, 1, size(INC, 1)))), 1)';
% DEPOS = ATTEDINC' * Rij';
% plot(16:50, poly, '.-b'); hold on;
% plot(16:50, DEPOS(1:35), '.-r'); hold on;
% return;

poly = sum(reshape(poly, 5, 7), 1);



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

component_search = 0:0.0001:0.7;

X = component_search;

Y = zeros(size(component_search, 2), 1);



for b = 1:4
    i = 1;
    
    for LI = component_search
        ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
        DEPOS = ATTEDINC' * Rij';
        %DEPOS = DEPOS(2:26);
        


%         if (LI ==  0.5001)
%             plot(14:50, INC, '.-b'); hold on;
%             plot(14:50, ATTEDINC, '.-r'); hold on;
%             plot(14:50, MDE, '.-k'); hold on;
%             
%             DEPOS5 = DEPOS;
%             
%             pause();
%         end

        DEPOS = DEPOS(1:35);
        
        LAMBDA = sum(reshape(DEPOS, 5, 7), 1)';

        %disp();

        %measurements = size(DETBINS, 2);
        f = 0.0;
        %for measure = 1:measurements
            for bin = b:b
                %abs(LAMBDA(bin) - DETBINS(bin, measure))
                %f = f + abs(LAMBDA(bin) - DETBINS(bin, measure));
                %Z(i2, i1) = abs(LAMBDA(bin) - DETBINS(bin, measure));
                %Y(i) = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
                %Y(i) = abs(LAMBDA(bin) - DETBINS(bin, measure));
                Y(i) = abs(LAMBDA(bin) - poly(bin));
                %f = f + (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
            end
        %end   
        
        
        if (Y(i) < mins(b))
            mins(b) = Y(i);
            minthicks(b) = LI;
        end
        
        i = i + 1;
    end
    
    %plot(X, Y, '.-b');
    
    %title(sprintf('%d bin - straight', b));
    %print(sprintf('plots/straight_%04d', b), '-dpng');
    
    %close all;
end


minthicks


mostleftthick = 1000;
mostrightthick = 0;
for i = 1:3
    if (minthicks(i) < mostleftthick) mostleftthick = minthicks(i); end
    if (minthicks(i) > mostrightthick) mostrightthick = minthicks(i); end
end

%blah
abs(mostrightthick - mostleftthick);
blah = blah + abs(mostrightthick - mostleftthick);
%blah

end


f = blah;


return;

%%%%% 3d - 2 components
% %alum_search = 0.19:0.0001:0.21;
% alum_search = 0:0.0001:0.3;
% cu_search = 0.02:0.0001:0.05;
% 
% [X,Y] = meshgrid(alum_search,cu_search);
% Z = zeros(size(X, 1), size(X, 2));
% 
% DISCRIM = ones(size(alum_search, 2), 1) * 10000;
% DISCRIM_PER = ones(size(alum_search, 2), 1) * 10000;
% 
% 
% for b = 3:3
%     
%     i1 = 1;
%     i2 = 1;
% 
%     for X1 = alum_search
%         i2 = 1;
%         for X2 = cu_search
%     % 
%              LI = zeros(2, 1);
%     %         X(1) = 0.198;
%     %         X(2) = 0.032;
%     % 
%     %         % X(1) = 0.3475;
%     %         % X(2) = 0.02784;
% 
%             LI(1) = X1;
%             LI(2) = X2;
% 
%             n = size(INC, 1);
% 
%             % ATT
%             % n
%             % repmat(X, 1, n)
%             % exp(-(ATT .* repmat(X, 1, n)))
%             % 
%             % GY = [1 2; 3 3; 4 4;];
%             % prod(GY , 1)
%             % 
%             % return;
% 
%             ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, n))), 1)';
%             DEPOS = ATTEDINC' * Rij';
%             %DEPOS = DEPOS(2:26);
% 
%             DEPOS = DEPOS(1:25);
%             LAMBDA = sum(reshape(DEPOS, 5, 5), 1)';
% 
% 
%             %disp();
% 
%             measurements = size(DETBINS, 2);
%             f = 0.0;
%             value = 0;
%             percent = 0;
%             for measure = 1:measurements
%                 for bin = b:b
%                     %abs(LAMBDA(bin) - DETBINS(bin, measure))
%                     %f = f + abs(LAMBDA(bin) - DETBINS(bin, measure));
%                     
%                     value = abs(LAMBDA(bin) - DETBINS(bin, measure));
%                     
%                     if (LAMBDA(bin) > DETBINS(bin, measure))
%                         percent = (LAMBDA(bin) / DETBINS(bin, measure)) - 1;
%                     else
%                         percent = (DETBINS(bin, measure) / LAMBDA(bin)) - 1;
%                     end
%                     %value = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
%                     
%                     Z(i2, i1) = value;
%                     
%                     %Z(i2, i1) = (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
%                     %f = f + (LAMBDA(bin) - log(LAMBDA(bin)) * DETBINS(bin, measure));
%                 end
%             end
% 
%             %disp(sprintf('%.6f', f));
% 
%             i2 = i2 + 1;
%             
%             
%             if (value < DISCRIM(i1))
%                 DISCRIM(i1) = value;
%             end
%             
%             if (percent < DISCRIM_PER(i1))
%                 DISCRIM_PER(i1) = percent;
%             end 
% 
%         end        
% 
%         i1 = i1 + 1;
%     end
%     
%     
%     plot(alum_search, DISCRIM_PER, '.-b');
%     %return;
%     
%     
%     b
%     
%     %surf(X,Y,Z, 'EdgeColor', 'none', 'FaceAlpha',0.7);
%     %colorbar;
% 
%     title(sprintf('%d bin - straight', b));
%     %print(sprintf('plots/straight_%04d', b), '-dpng');
%     
%     %close all;
%     
%     
% end






