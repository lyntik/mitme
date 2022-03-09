
%%% how inaccurate response corrupts decomposition (schlomka)

%%% TODO: make universal spectrum/deposited ranges

INC = INC_O;

atts = [];

MATERIALS = {'al', 'cu'};

ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(1))));
dd = double(ds);
atts(:,:) = dd(:,:);
atts = atts(19:42, :);

for i=2:size(MATERIALS, 2)
    ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(i))));
    dd = double(ds);
    atts(:,:,i) = dd(19:42, :);    
end


ATT = permute(atts(:, 2, :), [3, 1, 2]);


%%% ---- True response ----
Rij = zeros(26, 24);
for j = 19:42
    Rij(:, j - 18) = piecewiseBuild(j);
end


%%% ---- Attenuated detected bins ----

LI = [ 0.2; 0.05 ];
ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
DEPOS = ATTEDINC' * Rij';

poly = DEPOS(2:26);
poly = sum(reshape(poly, 5, 5), 1);
%%%
% 

%%% ---- Detected bins from incident spectrum ----

DEPOS_ = INC' * Rij';

%%% ---- Main ----

alum = zeros(15, 1);
cu = zeros(15, 1);
index = 1;
for deviation = 0:1:4

    Rij = zeros(26, 24);
    for j = 19:42
        Rij(:, j - 18) = piecewiseBuild(j, deviation);
    end

    tol = 1e-8; maxit = 100;

    optionsSART.nonneg = true;

    x0 = zeros(size(Rij, 2), 1);

    
    [incident_sle, info] = sart(Rij, double(DEPOS_'), 300, x0, optionsSART);
    INC = incident_sle;
    
%     plot(19:42, INC, '.-b');
%     return;
    

    integrals = decomp(INC, Rij, poly', MATERIALS);

    alum(index) = abs(LI(1) - integrals(1));
    cu(index) = abs(LI(2) - integrals(2));
    index = index + 1;
end

plot(0:1:4, alum(1:size(0:1:4, 2)) * 100. / LI(1), '.-b', 'DisplayName', 'Al deviation'); hold on;
plot(0:1:4, cu(1:size(0:1:4, 2)) * 100. / LI(2), '.-r', 'DisplayName', 'Cu deviation'); hold on;

xlabel('Inaccurate response, %');
ylabel('Thickness deviation, %');


legend('show');



