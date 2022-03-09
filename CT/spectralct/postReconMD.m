
a(:, :, 1) = [ 1 1 1; 
    2 2 2;]
% 
% a(:, :, 2) = [ 1 1 1; 
%     2 2 2;]
% 
% b = a(1,1,:);
% b = permute(b, [1 3 2]);
% 
% return;

% [x y] = loadXY('/opt/data/tube-spectrum.txt'); 
% plot(x, y, '.-b');
% 
% xlabel('Energy, keV');
% ylabel('Count, N');
% title('Wolfram tube spectrum, 160 keV');
% 
% return;


% 
% A = [];
% b = [];
% Aeq = [];
% beq = [];
% nonlcon = [];
% 
% lb = [ 15; 30; 50;  ];
% ub = [ 20; 40; 70;  ];
% % lb = zeros(2, 1);
% % ub = zeros(2, 1);
% % for i = 1:size(ub, 1)
% %     lb(i) = 0;
% %     ub(i) = 5;
% % end
% 
% 
% 
% img = loadMetaImage('/home/fna/dev/createtiff/build/fdk0.mha');
% n = numel(img(55:57, 75:77, 9:13));
% 
% X = [17 35 60 ];
% 
% %[X, fval, exitflag] = fmincon(@costMD, double(X), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals',10000000, 'MaxIter', 100000, 'TolX', 1, 'Display', 'None', 'Algorithm', 'sqp', 'DiffMinChange', 1, 'DiffMaxChange', 1.1 ) );
% %[X, fval, exitflag] = linprog(costMD(X), A, b, Aeq, beq, lb, ub, double(X), optimset('MaxFunEvals',10000000, 'MaxIter', 100000, 'TolX', 0.0000000001, 'Display', 'None', 'Algorithm', 'interior-point' ) );
% %[integrals, fval, exitflag] = fminsearch(@(integrals) cost(integrals, INC,D,Rij,ATT), double(integrals), optimset('MaxFunEvals',10000000, 'MaxIter', 300, 'TolX', 0.0001, 'Display', 'none') );
% [X, fval, exitflag] = fminsearch(@costMD, double(X), optimset('MaxFunEvals',10000000, 'MaxIter', 300, 'TolX', 0.0001, 'Display', 'none', 'DiffMinChange', 1) );
% 
% X
% fval
% 
% return;


global colors;


displayNames = {
    'SiO2'
    'CaCO3'
    'FeS2'
    'AlSi3O8'
    'PMMA'
    };

stats = {
%       '2E8'
%       '5E8'
%       '7E8'
%       '10E8'
       '5E9'
%       '10E8opt'
    };

pmma = zeros(numel(stats), 1);
sio2 = zeros(numel(stats), 1);
caco3 = zeros(numel(stats), 1);
fes2 = zeros(numel(stats), 1);
alsi3o8 = zeros(numel(stats), 1);

total = zeros(numel(stats), 1);

statIndex = 1;
for stat=1:numel(stats)



img = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/%s/fdk0.mha', str(char(stats(stat)))));


n = numel(img(55:57, 75:77, 9:13));

mu = zeros(4, 5);

for bin=1:4
    img = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/%s/fdk%d.mha', str(char(stats(stat))), bin-1));
    sprintf('/home/fna/dev/createtiff/build/%s/fdk%d.mha', str(char(stats(stat))), bin-1)
    
    mu(bin, 1) = sum(sum(sum(img(55:57, 75:77, 9:13), 1), 2), 3)/n;
    mu(bin, 2) = sum(sum(sum(img(72:74, 65:67, 9:13), 1), 2), 3)/n;
    mu(bin, 3) = sum(sum(sum(img(72:74, 45:47, 9:13), 1), 2), 3)/n;
    mu(bin, 4) = sum(sum(sum(img(55:57, 35:37, 9:13), 1), 2), 3)/n;
    mu(bin, 5) = sum(sum(sum(img(55:57, 53:55, 9:13), 1), 2), 3)/n;
end
% 
%MU
colorIndex = 1;
for m=1:5
    plot(1:4, mu(:, m), char(colors(colorIndex)), 'DisplayName', str(char(displayNames(m)))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
legend('show');
xticks(1:4);
title('Attenuation characteristics for bin borders 11,39,75,160 keV');
xlabel('Bin number');
ylabel(['Effective linear absorption coefficient cm ' char(175) char(185)]);


return;

%Slope
x1 = 1;
x2 = 2;

colorIndex = 1;

for m0=[1 2 3 4 5]
    
    heh = zeros(4, 1);
    i = 1;
    diff = zeros(4, 1);
    for m=[1 2 3 4 5]
        if (m == m0) 
            continue;
        end
        for b=2:4
            y1 = mu(b-1, m0);
            y2 = mu(b, m0);
            slope1 = -(y1-y2)/(x2-x1);

            y1 = mu(b-1, m);
            y2 = mu(b, m);
            slope2 = -(y1-y2)/(x2-x1);

            diff(i) = diff(i) + abs(slope1-slope2);

            %return;
        end
        
        diff(i) = diff(i)/3;
        heh(i) = m;
        i = i + 1;
    end
    
    plot(heh, diff, char(colors(colorIndex)), 'DisplayName', str(char(displayNames(m0)))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end    
end    

names = {'Sio2'; 'CaCO3'; 'FeS2'; 'AlSi3O8'; 'PMMA'};
set(gca,'xtick', [1:5], 'xticklabel',names)
title('ASD for bin borders 11,39,75,160 keV');
ylabel('ASD');

legend('show');
% 
return;

mats = zeros(112, 112, 5);

slices = zeros(112, 112, 4);
for bin=1:4
    img = loadMetaImage(sprintf('/home/fna/dev/createtiff/build/%s/fdk%d.mha', str(char(stats(stat))), bin-1));
    slices(:, :, bin) = img(:, :, 10);
end

A = [mu; 1 1 1 1 1];
for x=1:112
    for z=1:112
        b = ones(5, 1);
        b(1:4) = slices(z, x, :);
        mats(z, x, :) = lsqnonneg(A,b,[],1000);
    end
end


figure(1);
image(flip(mats(:, :, 1)) , 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('SiO2');
figure(2);
image(flip(mats(:, :, 2)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('CaCO3');
figure(3);
image(flip(mats(:, :, 3)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('FeS2');
figure(4);
image(flip(mats(:, :, 4)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('AlSi3O8');
figure(5);
image(flip(mats(:, :, 5)), 'CDataMapping','scaled'); colormap gray; c = colorbar; c.Label.String = 'Material dole'; ylabel('Pixel, Z direction'); xlabel('Pixel, X direction'); title('PMMA');


% 
% colorIndex = 1;
% 
% for m=1:5
%     plot(32:84, mats(55, 32:84, m), char(colors(colorIndex)), 'DisplayName', str(char(displayNames(m)))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end    
% end
% legend('show');

%img(288, 210, 36)


%image(img(:, :, 36), 'CDataMapping','scaled');
%colorbar;
n = numel(mats(55:57, 75:77, 5));
sio2(statIndex) = sum(sum(sum(mats(55:57, 75:77, 1), 1), 2), 3)/ n;
caco3(statIndex) = sum(sum(sum(mats(72:74, 65:67, 2), 1), 2), 3)/ n;
fes2(statIndex) = sum(sum(sum(mats(72:74, 45:47, 3), 1), 2), 3)/ n;
alsi3o8(statIndex) = sum(sum(sum(mats(55:57, 35:37, 4), 1), 2), 3)/ n;
pmma(statIndex) = sum(sum(sum(mats(55:57, 53:55, 5), 1), 2), 3)/ n;

total(statIndex) = (sio2(statIndex) + caco3(statIndex) + fes2(statIndex) + alsi3o8(statIndex) + pmma(statIndex)) / 5;

statIndex = statIndex + 1;

end
% 
% colorIndex = 1;
% plot(1:numel(stats), sio2, char(colors(colorIndex)), 'DisplayName', 'SiO2'); hold on; colorIndex = colorIndex + 1;
% plot(1:numel(stats), caco3, char(colors(colorIndex)), 'DisplayName', 'CaCO3'); hold on; colorIndex = colorIndex + 1;
% plot(1:numel(stats), fes2, char(colors(colorIndex)), 'DisplayName', 'FeS2'); hold on; colorIndex = colorIndex + 1;
% plot(1:numel(stats), alsi3o8, char(colors(colorIndex)), 'DisplayName', 'AlSi3O8'); hold on; colorIndex = colorIndex + 1;
% plot(1:numel(stats), pmma, char(colors(colorIndex)), 'DisplayName', 'PMMA'); hold on; colorIndex = colorIndex + 1;
% legend('show');


plot(1:numel(stats), total, '.-b');




