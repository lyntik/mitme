
colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };
colorIndex = 1;

%ds = dataset('File','spectral/spectrometer/1/n0_4_100.txt');

ds = dataset('File','spectral/spectrometer/1.0.txt');
dd = double(ds);
x = dd(:, 1);
y = dd(:, 2);

%plot(x, y, '.-b');
%return;

N0l = sum(y(find(x == 25.81):find(x == 28.44)))
N0h = sum(y(find(x == 52.2):find(x == 54.37)))


ds = dataset('File','spectral/spectrometer/experiment/1.0.txt');
dd = double(ds);
x = dd(:, 1);
y = dd(:, 2);
Nl = sum(y(find(x == 25.81):find(x == 28.44)))
Nh = sum(y(find(x == 52.2):find(x == 54.37)))



% M = [ 4.08700 133.711; 0.896800 19.7656; ];
% L = [ log(N0l / Nl); log(N0h / Nh) ];
% 
% Q = inv(M) * L


%%% space
space1 = 0.1:0.001:0.3;
space2 = 0.03:0.0001:0.04;


[x, y] = meshgrid(space1, space2);


cond = NaN(size(x));

i1 = 1;
for t1 = space1
    
    t1
    
    i2 = 1;
    
    for t2 = space2
    
        

        %for N0l_ = N0l - round(sqrt(N0l)):N0l + round(sqrt(N0l))
            %for N0h_ = N0h - round(sqrt(N0h)):N0h + round(sqrt(N0h))
            
        N0l_ = N0l;
        N0h_ = N0h;

                NLAMBDAl = N0l_ * exp(-4.08700 * t1) * exp(-133.711 * t2)
                NLAMBDAh = N0h_ * exp(-0.896800 * t1) * exp(-19.7656 * t2)
                
                return;

                z = 0;
                z = z + power(Nl - NLAMBDAl, 2) / NLAMBDAl;
                z = z + power(Nh - NLAMBDAh, 2) / NLAMBDAh;
                z = z / 2;
                z = power(z, 0.5);

                if (z < 1)
                    cond(i2, i1) = 0;
                end

            %end        
        %end
        
        i2 = i2 + 1;

    end
    
    i1 = i1 + 1;
end


surf(x, y, cond);
view(0,90);

axis([ space1(1) space1(length(space1)) space2(1) space2(length(space2)) ]);


return;

%d = 0.348;
%

%N0 = 2268;
%Nal = 30.83;


%m = (log(N0 / Nal) / d)
%return;

%N = Nal * exp(3.49086 * d);
N = Nal * exp(113.231 * d);

%N0 * exp(-113.231 * 0.032) * exp(3.49086 * 0.348)
N0 * exp(-134.8175 * 0.032) * exp(-3.9021 * 0.348)

N0
Nal
delta = N0 - N

%(log((N0 - delta) / Nal) / d)

return;



range = 0:0.05:5;



for d = 0.348 - 0.01:0.001:0.348 + 0.01

    S = zeros(size(range, 2), 1);
    i = 1;
    
    for m = range

        bestz = realmax;    

        for N0_ = N0 - round(sqrt(N0)):N0 + round(sqrt(N0))

            N = N0_ * exp(-m * d);

            z = (Nal - N) / sqrt(N);

            if (abs(z) < abs(bestz)) 
                bestz = z; 
            end
        end

        %if abs(bestz) < 5
            %if (abs(bestz) < abs(S(i)))
                S(i) = bestz;
            %end
        %end

        i = i + 1;

    end
    
    
    plot(range, S, char(colors(colorIndex)), 'DisplayName', sprintf('%.3f thick', d)); hold on;
    
    colorIndex = colorIndex + 1;
    if (colorIndex == size(colors, 2) + 1)
        colorIndex = 1;
    end

end

%plot(range, S, '.-b', 'DisplayName', 'z-scope < 1');
xlabel('Mu');
ylabel('z');
legend('show');

%m = log(N0/Nal) / (0.348)



return;

% Pal = 2.6989;
% 
% ds = dataset('File','spectral/spectrometer/ndiffraction0.txt');
% dd = double(ds);
% 
% plot(dd(:, 1), dd(:, 2), '.-b'); hold on;
% 
% 
% N0 = sum(dd(28, 2), 1);
% 
% ds = dataset('File','spectral/spectrometer/ndiffractional.txt');
% dd = double(ds);
% 
% plot(dd(:, 1), dd(:, 2), '.-r'); hold on;
% 
% Nal = sum(dd(28, 2), 1);
% 
% %d = log(N0/Nal) / (4.95)
% 
% m = log(N0 / Nal) / 0.348
% 
% 
% return;

% Pal = 2.6989;
% 
% ds = dataset('File','spectral/spectrometer/n0_stat.txt');
% dd = double(ds);
% 
% plot(dd(:, 1), dd(:, 2), '.-b'); hold on;
% 
% e = 20;
% 
% N0 = sum(dd(e:e, 2), 1);
% 
% ds = dataset('File','spectral/spectrometer/nal_stat.txt');
% dd = double(ds);
% 
% plot(dd(:, 1), dd(:, 2), '.-r'); hold on;
% 
% Nal = sum(dd(e:e, 2), 1);
% 
% %d = log(N0/Nal) / (4.95)
% 
% m = log(N0 / Nal) / 0.348
% 
% 
% return;

atts = [];

MATERIALS = {'al'};

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

LI = [ 0.2; ];
ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
%DEPOS = ATTEDINC' * Rij';

% N0 = sum(INC, 1);
% Nal = sum(ATTEDINC, 1);
N0 = INC(10);
Nal = ATTEDINC(10);



m = log(N0 / Nal) / (Pal * 0.2)

LI = [ 0.6; ];
ATTEDINC = INC .* prod(exp(-(ATT .* repmat(LI, 1, size(INC, 1)))), 1)';
%Nal = sum(ATTEDINC, 1);
Nal = ATTEDINC(10);

m = log(N0 / Nal) / (Pal * 0.6)

return;

% N0 = 5776;
% Nal = 2670;
% Ncu = 893;



%N = 545;
%N = 611;
%N = 563;
% N = 2018;

% poisson - ~ +-100
%715

Pal = 2.6989;
Pcu = 8.92;

Dal = 0.348;
Dcu = 0.032;

% a0 = log(N0/Nal) / ( Pal * Dal )
% a1 = log(N0/Ncu) / (Pcu * Dcu)
% 
% log(N0/N) / a0
% log(N0/N) / a0 / Pal

%%%%%%%%%%%% ---- 


% N0  5627 256
% Nal 1900 147
% Ncu 738  112


%33691 1702 32
%15622 1133 13
%5068 606 5

N0L = 149697;
N0H = 125331;
NalL = 47238;
NalH = 93682;
NcuL = 23803;
NcuH = 60196;

NL = NalL;
NH = NalH;


NL = 19146;
NH = 48174;

m1L = log(N0L / NalL) / (Pal * Dal);
m2L = log(N0L / NcuL) / (Pcu * Dcu);

m1H = log(N0H / NalH) / (Pal * Dal);
m2H = log(N0H / NcuH) / (Pcu * Dcu);

M = [ m1L m2L; m1H m2H; ];
L = [ log(N0L / NL); log(N0H / NH) ];

Q = inv(M) * L;

Q(1) / Pal
Q(2) / Pcu


return;



%d = log(N0 / N)  / (Pal * a0)
%return;

%d = (3.48 + 0.320);
d = (0.05 + 0.320);

% A = [a0 / 3.48  a1 / 0.32; 1 1 ]
% L = [log(N0/N) / d; 1  ]
A = [a0 a1 ; 1 1 ]
L = [log(N0/N); 1  ]


W = inv(A) * L

% 0.055 * 0.055 * d * W(1)
% 0.055 * 0.055 * d * W(2)
W(1) / Pal
W(2) / Pcu

W(1) / Pal



