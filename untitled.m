
%[raw] = loadMetaImage('e:/iffc/test4/corr100_3/fdk.mha');
[raw] = loadMetaImage('e:/iffc/test4/V/slice.mha');
imagesc(raw(:, :, 1));
raw = raw(:, :, 1);
x = 1524;
y = 1887;
r = raw(y:y+50, x:x+50);
r = reshape(r, [numel(r), 1]);
mean(r)/std(r)

return;

% 
% x = [0 2];
% y = [38494 31332];
% plot(x, y, '.-b'); hold on;
% 
% syms xx;
% f(xx) = 38494/exp(0.2059/2*xx);
% x = 0:0.1:2;
% plot(x, f(x), '.-r'); hold on;
% 
% plot(1, 34719, '*k'); hold on;
% 
% ax = gca;
% ax.XRuler.Exponent = 0;
% ax.YRuler.Exponent = 0;
% 
% return;

% t = Tiff('c:/Users/filatovna/AppData/Roaming/XROIL/T4/B1-gain-al1.0.tif', 'r');
% img = read(t);
% imagesc(img);

x = 1705;
y = 1746;

al = 0:34;

p = zeros(numel(al), 1);
al2 = zeros((numel(al)-1)*10, 1);
pexp = zeros((numel(al)-1)*10, 1);

t = zeros(numel(al), 1, 'double');
for i=1:numel(al)
    thick = al(i);
    f8num = double(idivide(int32(thick), 8));
    thick = mod(thick, 8);
    f5num = double(idivide(int32(thick), 5));
    f1num = mod(thick, 5);

    %t(i) = 0.93*f1num + 0.93*5.45*f5num + 0.93*(5.45+6.2)*f8num;
    t(i) = 0.93*f1num + 0.93*5.45*f5num + 0.93*(5.45+6.2)*f8num;
end

for i=1:numel(al)
    tif = Tiff(sprintf('c:/scans/iffc/B1-gain-al%02d.tif', al(i)), 'r');
    img = read(tif);

    p(i) = img(y, x);

    if (i > 1)
        syms xx;
        f(xx) = p(i-1)/exp(log(p(i-1)/p(i))/1*xx);
        pexp((i-2)*10+1:(i-2)*10+10) = f(0.1:0.1:1);

        step = (t(i)-t(i-1))/10;
        al2((i-2)*10+1:(i-2)*10+10) = t(i-1)+step:step:t(i);
    end
end

%plot(al, p, '.-b'); hold on;


plot(al2, pexp, '.-r'); hold on;
%plot(1.1:0.1:34, pexp, '.-r'); hold on;

ax = gca;
ax.XRuler.Exponent = 0;
ax.YRuler.Exponent = 0;
 

return;

SNRs = zeros(3, 1);

ii = 1;
for i=0.1:0.1:0.3
    [raw] = loadMetaImage(sprintf('c:/scans/test12/%.1f/slice.mha', i));


%     x = 1241;
%     y = 1247;
%     r = raw(y:y+50, x:x+50);
%     r = reshape(r, [numel(r), 1]);
%     SNRs(ii) = SNRs(ii) + mean(r)/std(r);
% 
%     x = 2746;
%     y = 1521;
%     r = raw(y:y+50, x:x+50);
%     r = reshape(r, [numel(r), 1]);
%     SNRs(ii) = SNRs(ii) + mean(r)/std(r);
% 
%     x = 640;
%     y = 1709;
%     r = raw(y:y+50, x:x+50);
%     r = reshape(r, [numel(r), 1]);
%     SNRs(ii) = SNRs(ii) + mean(r)/std(r);    
% 
%     x = 1780;
%     y = 1416;
%     r = raw(y:y+50, x:x+50);
%     r = reshape(r, [numel(r), 1]);
%     SNRs(ii) = SNRs(ii) + mean(r)/std(r);        

    x = 1647;
    y = 3332;
    r = raw(y:y+50, x:x+50);
    r = reshape(r, [numel(r), 1]);
    SNRs(ii) = SNRs(ii) + mean(r)/std(r);     

    ii = ii + 1;
    
end

SNRs
% 
%     imagesc(raw);
%     return;

return;

imagesc(raw);
r = raw(971:1070, 2175:2256);
r = reshape(r, [numel(r), 1]);
mean(r)
std(r)
% 

return;

% %15min 60min 15min comp
snrC = [2.5 5.4 4 7.8] ;
snrT = [8.5 16.2 12.8 25] ;


plot(1:4, snrC, '.-r', 'DisplayName', 'Prodis 2430C'); hold on;
plot(1:4, snrT, '.-b', 'DisplayName', 'Prodis 2430T'); hold on;
xticks([1 4])
xticklabels({'classic 15min','classic 60min','compensator 15min', 'compensator 60min'})

title('SNR 15min');

return;

%plot();

%%%% BH

k = 20;

% % 2430C
% 
% [x y] = loadXY('e:\scans\homogeneous_kern3\225kev-0.9ma-steel-60min\Vprep\profile.txt');
% plot(x, y .* k, '.-r', 'DisplayName', 'classic', 'LineWidth',1.5); hold on;
% % 
% % 
% [x y] = loadXY('e:\scans\homogeneous_kern3\225kev-3.5ma-compik-15min\V\profile.txt');
% plot(x, y .* k, '.-b', 'DisplayName', 'comensator', 'LineWidth',1.5); hold on;
% 
% title('Prodis 2430C Profiles');
% ylim([-0.7 1.2])
% 
% xlabel('Номер пикселя');
% legend('show');

% % 2430T
% [x y] = loadXY('e:\scans\tyumen-202111\Prodis-2430T\225kev-1.2ma-steel-1.5deg-15min\Vprep\profile.txt');
% plot(x, y .* k, '.-r', 'DisplayName', 'classic', 'LineWidth',1.5); hold on;
% 
% [x y] = loadXY('e:\scans\tyumen-202111\Prodis-2430T\compik4cm\vanil2_15min\V\profile.txt');
% plot(x, y .* k * 1.4, '.-b', 'DisplayName', 'compensator', 'LineWidth',1.5); hold on;
% 
% title('Prodis 2430T Profiles');
% ylim([-0.7 1.2])
% 
% xlabel('Номер пикселя');
% legend('show');


return;

[x y] = loadXY('c:\scans\attackOnSyryamkin\knifeY.txt');

%plot(x, y, '.-b');
y = gradient(y);

plot(x, y, '.-b');
%y = gradient(y);

title('Y knife, M87, spatial 1um');

return;

[x y] = loadXY('c:/scans/jima.txt');
y = -1 * y;

plot(x+1, y, '.-b');
% 
%[r] = calcMTFs(-1*y, 0, 7);
% a = [];
% a(1) = 1;
% a(2) = 1;

extrems = [];
state = 0;
if (y(2) > y(1))
    lastdir = 0;
else
    lastdir = 1;
end

ind = 1;
for i=3:numel(y)
    if (y(i) > y(i-1))
        dir = 0;
    else
        dir = 1;
    end
    
    if (state == 0 && lastdir == 0 && dir == 1)
        extrems(ind) = i-1;
        ind = ind + 1;
        state = 1;
    end
    
    if (state == 1 && lastdir == 1 && dir == 0)
        extrems(ind) = i-1;
        ind = ind + 1;
        state = 0;
    end

    lastdir = dir;

end

if (state == 0)
    extrems = extrems(1:numel(extrems) - 1);
end

extrems

% if (0==1 | 1==0)
%     x = 12
% end

%for i

return;


axe = 'x';
x1 = 1253;
x2 = 1218;
y = 25:35;
f = -1;

t = Tiff('c:\scans\3.tif' ,'r');
img = read(t);
imagesc(img);

if (axe == 'y')
    img = img';
end

%x = x1;

g = zeros(abs(x2-x1)+1, 1);
i = 1;
for xx=x1:f:x2
    g(i) = mean(img(y, xx));
    i = i + 1;
end

[v x] = max(gradient(g))
x = x1 + (x-1)*f;

%t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');

% if (flipx)
%     img = flip(img, 2);
% end


p1 = mean(img(y, x-f))
p2 = mean(img(y, x))

x

return;



%minima


% [x y] = loadXY('c:\work\t4\release\bin\MIRA.txt');
%  
% plot(1:numel(y), y, '.-b');
% [mtfs] = calcMTFs(y, 0, 11);
% min(mtfs)



return;

pairs = 5:6;
mtfs = zeros(numel(pairs), 1);
ind = 1;
for i=pairs
    [x y] = loadXY(sprintf('d:/mira/B1/values_M1.25_%d.txt', i));
    
    [r] = calcMTFs(y, 0, 11);
    
    mtfs(ind) = mean(r);
    ind = ind + 1;
end
plot(pairs, mtfs.*100, '.-g', 'DisplayName', 'radiography M1.25'); hold on;
% 

% 
pairs = 5:8;
mtfs = zeros(numel(pairs), 1);
ind = 1;
for i=pairs
    [x y] = loadXY(sprintf('d:/mira/B1/values_M1_%d.txt', i));
    
    [r] = calcMTFs(y, 0, 11);
    
    mtfs(ind) = mean(r);
    ind = ind + 1;
end
plot(pairs, mtfs.*100, '.-m', 'DisplayName', 'radiography M1'); hold on;

% i = 5;
% [x y] = loadXY(sprintf('d:/mira/B1/values_CT_B1_%d.txt', i));
% plot(x, y, '.-b');
% 
% return;


pairs = 3:4;
mtfs = zeros(numel(pairs), 1);
ind = 1;
for i=pairs
    [x y] = loadXY(sprintf('d:/mira/B1/values_CT_B2_%d.txt', i));
    
    [r] = calcMTFs(y, 0, 10);
    
    mtfs(ind) = mean(r);
    ind = ind + 1;
end
plot(pairs, mtfs.*100, '.-c', 'DisplayName', 'tomography MIRA'); hold on;


pairs = 4:5;
mtfs = zeros(numel(pairs), 1);
ind = 1;
for i=pairs
    [x y] = loadXY(sprintf('d:/mira/B1/values_CT_B1_%d.txt', i));

    
    [r] = calcMTFs(y, 0, 10);
    
    mtfs(ind) = mean(r);
    ind = ind + 1;
end
plot(pairs, mtfs.*100, '.-r', 'DisplayName', 'tomography MIRA'); hold on;


pairs = 2:3;
mtfs = zeros(numel(pairs), 1);
ind = 1;
for i=pairs
    [x y] = loadXY(sprintf('d:/mira/B1/values_CT_B1_CYL_%d.txt', i));
    y = abs(y-max(y));
    
    [r] = calcMTFs(y, 0, 10);
    
    mtfs(ind) = mean(r);
    ind = ind + 1;
end
plot(pairs, mtfs.*100, '.-b', 'DisplayName', 'tomography MIRA+Al Cylinder'); hold on;

% 
% 
% plot(x, y, '_k', 'MarkerIndices', [10], ...
%     'MarkerFaceColor','red', ...
%     'MarkerSize',1); hold on;

xticklabels(uint16(500./[2 3 4 5 6 7 8]));
ylabel('MTF, %');
xlabel('um');
%xticks(pairs);
legend('show');



x = [2 8];
y = [10 10];
line(x,y,'Color','black','LineStyle','--')

x = [3.1 3.1];
y = [0 10];
line(x,y,'Color','blue','LineStyle','--')
text(3.1,5,'\leftarrow 161.3 um', 'Color','blue', 'FontSize',12)

x = [4 4];
y = [0 10];
line(x,y,'Color','cyan','LineStyle','--')
text(4, 5,'\leftarrow 125 um', 'Color','cyan', 'FontSize',12)

x = [5.1 5.1]; 
y = [0 10];
line(x,y,'Color','red','LineStyle','--')
text(5.1,5,'\leftarrow 98.04 um', 'Color','red', 'FontSize',12)

x = [5.75 5.75];
y = [0 10];
line(x,y,'Color','green','LineStyle','--')
text(5.75,5,'\leftarrow 87 um', 'Color','green', 'FontSize',12)

x = [7.5 7.5];
y = [0 10];
line(x,y,'Color','magenta','LineStyle','--')
text(7.5,5,'\leftarrow 66.6 um', 'Color','magenta', 'FontSize',12)


legend('radiography M1.25', 'radiography M1', 'tomography MIRA Binning2', 'tomography MIRA', 'tomography MIRA+Al Cylinder');


