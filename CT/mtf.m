
arr = [16];
%arr = 8;
mtfSART = zeros(numel(arr), 1);
mtfFDK = zeros(numel(arr), 1);
mtfConj = zeros(numel(arr), 1);
mtfRegul = zeros(numel(arr), 1);

index = 1;
for lines=arr
    mtfFDK(index) = calcMtf(sprintf('/home/fna/dev/krasnoyarsk/tools/drawings/mtfsample/build/volumes/fdk-%d.mha', lines), lines);
    return;
    mtfSART(index) = calcMtf(sprintf('/home/fna/dev/krasnoyarsk/tools/drawings/mtfsample/build/volumes/sart-%d.mha', lines), lines);
    mtfConj(index) = calcMtf(sprintf('/home/fna/dev/krasnoyarsk/tools/drawings/mtfsample/build/volumes/conj-%d.mha', lines), lines);
    mtfRegul(index) = calcMtf(sprintf('/home/fna/dev/krasnoyarsk/tools/drawings/mtfsample/build/volumes/regul-%d.mha', lines), lines);
    
    index = index + 1;
end


plot(arr, mtfSART, '.-g', 'DisplayName', 'SART'); hold on;
plot(arr, mtfFDK, '.-r', 'DisplayName', 'FDK'); hold on;
plot(arr, mtfConj, '.-b', 'DisplayName', 'Conjugate Gradient'); hold on;
plot(arr, mtfRegul, '.-k', 'DisplayName', 'Regul'); hold on;
legend('show');

xlabel('Линий/мм');
ylabel('ПФМ');