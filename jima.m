

mtf = zeros(2, 1);

%% 

% M25
[x y] = loadXY('c:\1\5um-70kev-50mka\0_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);

[x y] = loadXY('c:\1\5um-70kev-50mka\0_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);

plot(5:-1:4, mtf, '.-b', 'DisplayName', 'focus 5um, 70keV, 50mkA'); hold on;


[x y] = loadXY('c:\1\8um-100kev-50mka\0_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);

[x y] = loadXY('c:\1\8um-100kev-50mka\0_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);

plot(5:-1:4, mtf, '.-r', 'DisplayName', 'focus 8um, 100keV, 50mkA'); hold on;
legend('show');

h = yline(0.1, 'k-', 'LineWidth', 2);
line([4.6 4.6], [0 0.1], 'Color','red','LineStyle','--');
line([4.06 4.06], [0 0.1], 'Color','blue','LineStyle','--');


title('JIMA resolution est. (Hamamatsu L9181-02, Teledyne Gd 0.495) M25.65');
set(gca, 'XDir','reverse');
xticks([4, 4.06, 4.6, 5]);
xlabel('Resolution, um');
ylabel('MTF');

x0=10;
y0=10;
width=1200;
height=800
set(gcf,'position',[x0,y0,width,height])

%%
% M20
[x y] = loadXY('c:\1\5um-70kev-50mka\2500_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);

[x y] = loadXY('c:\1\5um-70kev-50mka\2500_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);

plot(5:-1:4, mtf, '.-b', 'DisplayName', 'focus 5um, 70keV, 50mkA'); hold on;


[x y] = loadXY('c:\1\8um-100kev-50mka\2500_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);


[x y] = loadXY('c:\1\8um-100kev-50mka\2500_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);
mtf(2) = 0;

plot(5:-1:4, mtf, '.-r', 'DisplayName', 'focus 8um, 100keV, 50mkA'); hold on;
legend('show');

h = yline(0.1, 'k-', 'LineWidth', 2);



title('JIMA resolution est. (Hamamatsu L9181-02, Teledyne Gd 0.495) M20');
set(gca, 'XDir','reverse');
xticks([4, 4.06, 4.6, 5]);
xlabel('Resolution, um');
ylabel('MTF');

x0=10;
y0=10;
width=1200;
height=800
set(gcf,'position',[x0,y0,width,height])

%% 

% M15
[x y] = loadXY('c:\1\5um-70kev-50mka\5000_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);

[x y] = loadXY('c:\1\5um-70kev-50mka\5000_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);

plot(5:-1:4, mtf, '.-b', 'DisplayName', 'focus 5um, 70keV, 50mkA'); hold on;


[x y] = loadXY('c:\1\8um-100kev-50mka\5000_5um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(1) = min(mtfs);

[x y] = loadXY('c:\1\8um-100kev-50mka\5000_4um.txt');
%plot(1:numel(y), y.*(-1), '.-b');
[mtfs] = calcMTFs(-1.*y, 0, 7);
mtf(2) = min(mtfs);

plot(5:-1:4, mtf, '.-r', 'DisplayName', 'focus 8um, 100keV, 50mkA'); hold on;
legend('show');

h = yline(0.1, 'k-', 'LineWidth', 2);
% line([4.6 4.6], [0 0.1], 'Color','red','LineStyle','--');
% line([4.06 4.06], [0 0.1], 'Color','blue','LineStyle','--');


title('JIMA resolution est. (Hamamatsu L9181-02, Teledyne Gd 0.495) M15.7846');
set(gca, 'XDir','reverse');
xticks([4, 5]);
xlabel('Resolution, um');
ylabel('MTF');


x0=10;
y0=10;
width=1200;
height=800
set(gcf,'position',[x0,y0,width,height])

