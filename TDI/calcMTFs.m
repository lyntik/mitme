function mtfs=calcMTFs(profile, thr, minimums)

out = extrems(profile);


out.minx

% try to locate target maximums

% maxx = [];
% maxy = [];

% middle = fix(numel(out.maxx)/2);
% maxx(1) = out.maxx(middle);
% maxy(1) = out.maxy(middle);
% ind = 2;
% for i=middle+1:numel(out.maxx)
%     if (abs(out.maxy(i)-maxy(ind-1))/out.maxy(i) > thr)
%         break;
%     end
%     maxx(ind) = out.maxx(i);
%     maxy(ind) = out.maxy(i);
%     ind = ind + 1;
% end    
% ind = 2;
% for i=middle-1:-1:1
%     if (abs(out.maxy(i)-maxy(ind-1))/out.maxy(i) > thr)
%         break;
%     end
%     if (i == middle-1)
%         ind = numel(maxx) + 1;
%     end
%     maxx(ind) = out.maxx(i);
%     maxy(ind) = out.maxy(i);
%     ind = ind + 1;
% end    

% calculate mtf for each maximum

minx = out.minx;
miny = out.miny;

mtfs = zeros(numel(minx), 1);

if (numel(minx) < minimums)
    return;
end    

background = min(profile);

for i=1:numel(minx)
    y = miny(i);
    x = minx(i);
    
    y2_1 = 0;
    for f=x-1:-1:1
        if (sum(out.maxx==f) == 1)
           y2_1 = out.maxy(out.maxx==f);
           break;
        end
    end
    y2_2 = 0;
    for f=x+1:1:numel(profile)
        if (sum(out.maxx==f) == 1)
           y2_2 = out.maxy(out.maxx==f);
           break;
        end
    end
    
%     x
%     y
%     y2
    
    c = 0;
    if (y2_1 ~= 0)
        c = c + 1;
    end
    if (y2_2 ~= 0)
        c = c + 1;
    end
    if (c == 0) 
        return;
    end
    y2 = (y2_1+y2_2)/c;
    %y2 = max(y2_1, y2_2);
        
    I1 = y - background;
    I2 = y2 - background;
 
    mtfs(i) = abs(I1-I2)/(I1+I2);
end

mtfs

mtfs = sort(mtfs);
mtfs = mtfs(numel(miny)-minimums+1:end);



%%%% USAGE

% startcol = 135;
% starty1 = 28;
% starty2 = 72;
% slope = 12.36;
% % % 
% col = 161;
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

