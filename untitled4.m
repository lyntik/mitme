

r0 = zeros(2, 1);
r1 = zeros(2, 1);

i0right = zeros(2, 1);
i1right = zeros(2, 1);

i0left = zeros(2, 1);
i1left = zeros(2, 1);

all0 = zeros(2, 1);
all1 = zeros(2, 1);

img = read(Tiff('c:/work/build-t4all-Desktop_Qt_5_12_10_MSVC2017_64bit-release/bin/nofilter/0.tif', 'r'));
imagesc(img);
roi = img(1197:1371, 2054:2230);
rightI = mean(mean(roi))

roi = img(1167:1371, 78:223);
leftI = mean(mean(roi))

i0right(1) = rightI;
i0left(1) = leftI;
r0(1) = rightI/leftI


roi = img(1167:1371, 78:2201);
all0(1) = mean(mean(roi));


img = read(Tiff('c:/work/build-t4all-Desktop_Qt_5_12_10_MSVC2017_64bit-release/bin/nofilter/1.tif', 'r'));
imagesc(img);
roi = img(1197:1371, 2054:2230);
rightI = mean(mean(roi))

roi = img(1167:1371, 78:223);
leftI = mean(mean(roi))

i1right(1) = rightI;
i1left(1) = leftI;
r1(1) = rightI/leftI

roi = img(1167:1371, 78:2201);
all1(1) = mean(mean(roi));



img = read(Tiff('c:/work/build-t4all-Desktop_Qt_5_12_10_MSVC2017_64bit-release/bin/filter/0.tif', 'r'));
imagesc(img);
roi = img(1197:1371, 2054:2230);
rightI = mean(mean(roi))

roi = img(1167:1371, 78:223);
leftI = mean(mean(roi))

i0right(2) = rightI;
i0left(2) = leftI;
r0(2) = rightI/leftI

roi = img(1167:1371, 78:2201);
all0(2) = mean(mean(roi));

img = read(Tiff('c:/work/build-t4all-Desktop_Qt_5_12_10_MSVC2017_64bit-release/bin/filter/1.tif', 'r'));
imagesc(img);
roi = img(1197:1371, 2054:2230);
rightI = mean(mean(roi))

roi = img(1167:1371, 78:223);
leftI = mean(mean(roi))

i1right(2) = rightI;
i1left(2) = leftI;
r1(2) = rightI/leftI

roi = img(1167:1371, 78:2201);
all1(2) = mean(mean(roi));

% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = read(Tiff('c:/work/build-t4all-Desktop_Qt_5_12_10_MSVC2017_64bit-release/bin/closer_max_tube_rot.tif', 'r'));

roi = img(1167:1371, 78:2201);
all_ = mean(mean(roi));

roi = img(1197:1371, 2054:2230);
rightI = mean(mean(roi))

roi = img(1167:1371, 78:223);
leftI = mean(mean(roi))

% 
% plot(1:2, all0, '.-b'); hold on;
% plot(1:2, all1, '.-r'); hold on;
% plot(2, all_, '.-k'); hold on;

% plot(1:2, r0, '.-b'); hold on;
% plot(1:2, r1, '.-r'); hold on;

plot(1:2, i0right, '.-b'); hold on;
plot(1:2, i1right, '.-r'); hold on;

plot(1:2, i0left, 'o-b'); hold on;
plot(1:2, i1left, 'o-r'); hold on;

plot(2, leftI, 'o-g'); hold on;
plot(2, rightI, 'o-k'); hold on;


