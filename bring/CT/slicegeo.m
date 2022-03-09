
% t = Tiff('/media/fna/storage 2T/scans/poli2/kern2/comparison/0.1.tif','r');
% img = read(t);
% plot(1:2304/4, sum(reshape(img(1160, :), 4, 576)), '.-b', 'DisplayName', '0.1 degree'); hold on;
% 
% t = Tiff('/media/fna/storage 2T/scans/poli2/kern2/comparison/0.5.tif','r');
% img = read(t);
% plot(1:2304/4, sum(reshape(img(1160, :), 4, 576)), '.-r', 'DisplayName', '0.5 degree'); hold on;
% 
% %print('-clipboard','-dbitmap');
% legend('show');

stds = zeros(5, 1);
i = 1;
for a = 0.1:0.1:0.5
    t = Tiff(sprintf('/media/fna/storage 2T/scans/poli2/kern2/comparison/%.1f.tif', a),'r');
    img = read(t);
    roi = img(706:729, 980:1030);
    stds(i) = std(double(reshape(roi, numel(roi), 1)));
    i = i + 1;
end
plot(0.1:0.1:0.5, stds, '.-b');
xticks([0.1:0.1:0.5]);
set(gca,'XDir','reverse')
xlabel('Angle step, deg');
ylabel('STD');
%xticks([0.1:0.1:0.5]);
%xlabel5();
%ylabel();

%plot(1:2304/4, sum(reshape(img(1160, :), 4, 576)), '.-b', 'DisplayName', '0.1 degree'); hold on;