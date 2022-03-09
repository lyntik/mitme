
%%% CKO
s = zeros(3, 1);

[raw] = loadMetaImage('/home/fna/dev/krasnoyarsk/tools/bhcorrection/build/paraffin/fdk.mha');
plot(1:1000, raw(850, 1:1000, 5), '.-r', 'DisplayName', 'Оригинальный срез'); hold on;


s(1) = std(raw(850, 1:1000, 5));


[raw] = loadMetaImage('/home/fna/dev/krasnoyarsk/tools/bhcorrection/build/fdk_bh1.mha');
plot(1:1000, raw(850, 1:1000, 5), '.-r'); hold on;
s(2) = std(raw(850, 1:1000, 5));

[raw] = loadMetaImage('/home/fna/dev/krasnoyarsk/tools/bhcorrection/build/paraffin/fdk_bh2.mha');
plot(1:1000, raw(850, 1:1000, 5), '.-b', 'DisplayName', 'Корректированный срез'); hold on;
s(3) = std(raw(850, 1:1000, 5));

xlabel('Пиксель');
ylabel('Интенсивность, I');
legend('show');

bar(s, 0.5)
set(gca,'xticklabel',{'Оригинал','Полином','Гаусс'});
ylabel('СКО');

return;

%%% GaussSub

x = 1:65535;
y1 = log(65535 ./ x);
plot(x, y1, '.-b', 'DisplayName', 'Линеризация по экспоненте'); hold on;

y2 = 1.*exp(-(x+8000).^2/(2*10000^2));
plot(x,y2, '.-r', 'DisplayName', 'Корректирующий Гаусс'); 
ax = gca;
ax.YRuler.Exponent = 0;
ax.XRuler.Exponent = 0;


y = y1 - y2;
plot(x,y, '.-g', 'DisplayName', 'Корректированная линеризация '); 

xlabel('Интенсивность, I');
ylabel('Суммарный коэф. поглощения, см^-1');
legend('show');

return;

%%% Histogram

[raw] = loadMetaImage('/home/fna/dev/krasnoyarsk/tools/bhcorrection/build/projs16.mha');

histogram(raw);
xlabel('Интенсивность, I');
ylabel('Количество пикселей, N');
ax = gca;
ax.YRuler.Exponent = 0;
ax.XRuler.Exponent = 0;


return;


