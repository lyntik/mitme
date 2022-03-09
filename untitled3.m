

[raw] = loadMetaImage('d:\mira\B1_CYL\V\slice.mha');
roi = raw(1487:3242, 1871:2926);
disp('all')
average = mean(mean(roi))

std(reshape(roi, [numel(roi) 1]))/mean(mean(roi))

roi = raw(2224:2324, 2290:2390);
disp('center')
v = mean(mean(roi))
(mean(mean(roi)) - average) / average

roi = raw(2224:2324, 1390:1400);
disp('left')
v = mean(mean(roi))
(mean(mean(roi)) - average) / average

roi = raw(2224:2324, 3311:3411);
disp('right')
v = mean(mean(roi))
(mean(mean(roi)) - average) / average


roi = raw(1388:1398, 2290:2390);
disp('top')
v = mean(mean(roi))
(mean(mean(roi)) - average) / average

roi = raw(3202:3212, 2290:2390);
disp('bottom')
v = mean(mean(roi))
(mean(mean(roi)) - average) / average




%imagesc(raw);
