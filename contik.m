
%% 
[x y] = loadXY('f:\scans\avg1\profile.txt');
plot(1:numel(y), y, '.-b');

%%
I1 = (0.2165 + 0.2105) / 2;
I2 = 0.208;
mtf = abs(I1-I2) / (I1 + I2)


%%
mtf = zeros(2, 1);


% contik-avg1
I1 = (0.2701 + 0.27) / 2;
I2 = 0.2106;
mtf(2) = abs(I1-I2) / (I1 + I2);

plot(2, mtf(2), '.-b', 'DisplayName', 'contik-avg1'); hold on;

% contik-avg2
I1 = (0.416941 + 0.408609) / 2;
I2 = 0.202;
mtf(1) = abs(I1-I2) / (I1 + I2);

I1 = (0.2858 + 0.2852) / 2;
I2 = 0.1930;
mtf(2) = abs(I1-I2) / (I1 + I2);
plot(1:2, mtf, '.-g', 'DisplayName', 'contik-avg2'); hold on;


% contik-avg5
I1 = (0.41588 + 0.4185) / 2;
I2 = 0.258;
mtf(1) = abs(I1-I2) / (I1 + I2);

I1 = (0.31027 + 0.31316) / 2;
I2 = 0.263171;
mtf(2) = abs(I1-I2) / (I1 + I2);
plot(1:2, mtf, '.-r', 'DisplayName', 'contik-avg5'); hold on;

% contik-avg10_

I1 = (0.372971 + 0.365747) / 2;
I2 = 0.266;
mtf(1) = abs(I1-I2) / (I1 + I2);

I1 = (0.308891 + 0.29118) / 2;
I2 = 0.26231;
mtf(2) = abs(I1-I2) / (I1 + I2);
plot(1:2, mtf, '.-m', 'DisplayName', 'contik-avg10'); hold on;


% 100-0.1-30

I1 = (0.4270 + 0.4059) / 2;
I2 = 0.205585;
mtf(1) = abs(I1-I2) / (I1 + I2);

I1 = (0.284287 + 0.3155) / 2;
I2 = 0.2171;
mtf(2) = abs(I1-I2) / (I1 + I2);
plot(1:2, mtf, '.-k', 'DisplayName', '100-0.1-30'); hold on;

legend('show');





