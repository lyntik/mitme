

%%% geant4 spectrum

w_exp = solidAngleIdealGeomDetectorSource(1000, 1000, 1000)
w_etalon = solidAngleIdealGeomDetectorSource(1, 1, 1000)

solid_norm = w_etalon / w_exp;
e_norm = (6.25 * 10^15) / 1680000000; % I = Nq/t (A, s, q = 1.6*10^-19 )

norm = solid_norm * e_norm;

ds = dataset('File',sprintf('%s/mu/al.txt', DATA_PATH));
al = double(ds);
al = al(:, 2);

ds = dataset('File',sprintf('%s/set1/G4_W_10degrees_1000x1000%%1000.dat', DATA_PATH));
dd = double(ds);

plot(0:1:100, dd(:, 2) .* norm .* exp(-al .* 0.15) * 2,  '.-b'); hold on;

%%% xop spectrum


ds = dataset('File',sprintf('%s/set1/xop_spectrum.txt', DATA_PATH));
dd = double(ds);
plot(0:1:100, dd(1:101, 2), '.-g'); hold on;


