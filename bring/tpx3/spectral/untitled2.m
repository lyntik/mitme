
%% --------------------- bins

figure('rend', 'painters', 'pos', [500 500 1100 800]);

imageData0 = zeros(256, 256, 130);


for b=1:130
    t = Tiff(sprintf('/home/user/dev/pixetsdk/tifs/I0/%d.tif', b), 'r');
    imageData0(:, :, b) = double(read(t));
end

frames0 = zeros(256, 256, 10);
i = 1;
for b=1:10:100
    frames0(:, :, i) = sum(imageData0(:, :, b:b+9), 3);
    i = i + 1;
end

imageData = zeros(256, 256, 130);

for b=1:130
    t = Tiff(sprintf('/home/user/dev/pixetsdk/tifs/Phantom/%d.tif', b), 'r');
    imageData(:, :, b) = double(read(t));
end

frames = zeros(256, 256, 10);
i = 1;
for b=1:10:100
    frames(:, :, i) = sum(imageData(:, :, b:b+9), 3);
    i = i + 1;
end

f = zeros(256, 256, 10);
for b=1:10
    f(:, :, b) = frames(:, :, b)./frames0(:, :, b);
end

y = 100:115;
rKI = permute(sum(f(y, 30, :), 1)/numel(y), [3 2 1]);
rGd = permute(sum(f(y, 160, :), 1)/numel(y), [3 2 1]);
rPMMA = permute(sum(f(y, 90, :), 1)/numel(y), [3 2 1]);

%imagesc(f(:, :, 5));

plot(1:10, log(1./rKI), '.-b', 'DisplayName', 'KI'); hold on;
plot(1:10, log(1./rGd), '.-r', 'DisplayName', 'Gd'); hold on;
plot(1:10, log(1./rPMMA), '.-k', 'DisplayName', 'PMMA'); hold on;
legend('show');


xlabel('TOT');
ylabel('Count, N');
%title('mu, bins - each 10 TOT, multi pixs');
title(sprintf('20 min, mu, bins - each 10 TOT, %d pix(s)', numel(y)));




%% --------------------- frames

% imagesc(imageData(:, :, 55));

figure('rend', 'painters', 'pos', [500 500 1100 800]);
%suptitle({'', 'frame'});

for i=1:8
    subplot(2,4,i);
    imagesc(f(:, :, i));
    title(sprintf('%d bin', i));
    lim = caxis
    
    
    caxis([0.2 1.2])
end    



%% --------------------- resolution

figure(3);

imageData = zeros(256, 256, 130);

for b=1:130
    t = Tiff(sprintf('/home/user/dev/pixetsdk/tifs/%d.tif', b), 'r');
    imageData(:, :, b) = double(read(t));
end

syms x;
g(x)=x;

figure('rend', 'painters', 'pos', [500 500 1100 800]);
suptitle({'', '60 min, energy resolution 1 VS multi pix', '', '', ''});

subplot(2,1,1);
y = 100;
s = permute(sum(imageData(y, 90, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-b'); hold on;
s = permute(sum(imageData(y, 30, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-r'); hold on;
s = permute(sum(imageData(y, 160, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-k'); hold on;
title('1 pix');
xlabel('TOT');
ylabel('Count, N');

subplot(2,1,2);
y = 100:120;
s = permute(sum(imageData(y, 90, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-b'); hold on;
s = permute(sum(imageData(y, 30, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-r'); hold on;
s = permute(sum(imageData(y, 160, :), 1) / numel(y), [3 2 1]);
plot(g(1:130), s, '.-k'); hold on;
title('21 pixs');
xlabel('TOT');
ylabel('Count, N');


%% --------------------- count bars

imageData = zeros(256, 256, 130);

for b=1:130
    t = Tiff(sprintf('/home/user/dev/pixetsdk/tifs/%d.tif', b), 'r');
    imageData(:, :, b) = double(read(t));
end

y = 100:120;
sKI = permute(sum(imageData(y, 30, :), 1) / numel(y), [3 2 1]);
sGd = permute(sum(imageData(y, 160, :), 1) / numel(y), [3 2 1]);
sPMMA = permute(sum(imageData(y, 90, :), 1) / numel(y), [3 2 1]);


X = categorical({'PMMA','Gd','KI'});
X = reordercats(X,{'PMMA','Gd','KI'});
bar(X, [sum(reshape(sPMMA(1:100), [10 10]), 1)/.60; sum(reshape(sGd(1:100), [10 10]), 1)/.60; sum(reshape(sKI(1:100), [10 10]), 1)/.60]);
title({'TPX3 DDM, 25kk pix/s', 'Counts per pixel for 1min for each 10keV step bins '});
ylabel('Counts');


