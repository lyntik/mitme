
%ATT = loadAttenuation({'h2o', 'ki'}, 1:33);
%ATT = loadAttenuation({'al'}, 1:31);
ATT = loadAttenuation({'cu'}, 1:13);
%ATT = mu';
%ATT = ATT(1:23);

%ATT = [ ATT(:, 1:15) ATT(:, 18:20) ATT(:, 27:29) ];
%ATT = [ ATT(:, 1:15) ATT(:, 24:29) ];

load('recon_inc');
INC = spectrum;
%INC = INC(1:23);
%INC = [ INC(1:15); INC(18:20); INC(27:29);  ]
%INC = [ INC(1:15); INC(24:29);  ]

load('recon_measure');
%spectrum = [ spectrum(1:15); spectrum(18:20); spectrum(27:29);  ];
%spectrum = [ spectrum(1:15); spectrum(24:29);  ];
%spectrum = spectrum(1:23);
X = sum(spectrum);


%%% thickness
space = 0.0:0.00001:0.6;

x = space;
y = NaN(1, size(x, 2));
i = 1;

for t = space
    LAMBDA = sum(INC .* prod(exp(-ATT .* repmat(t, 1, size(INC, 1))), 1)');
    z = abs((X - LAMBDA) / sqrt(LAMBDA));
    
    if z < 50
        y(i) = z;
    end
    
    i = i + 1;
end

plot(x, y, '.-b');

return;

%%% proportion
space = 0.0:0.001:1;

x = space;
y = NaN(1, size(x, 2));
i = 1;

t = 0.97;

for p = space
    t_ = zeros(2, 1);
    t_(1) = t * p;
    t_(2) = t * (1 - p);
    
    %t_(3) = 0.188;
    
    LAMBDA = sum(INC .* prod(exp(-ATT .* repmat(t_, 1, size(INC, 1))), 1)');
    z = abs((X - LAMBDA) / sqrt(LAMBDA));
    
    if z < 10
        y(i) = z;
    end
    
    i = i + 1;
end

plot(1:size(spectrum, 1), spectrum, '.-b'); hold on;
p = 0.9718;
t_ = zeros(2, 1);
t_(1) = t * p;
t_(2) = t * (1 - p);
LAMBDA = INC .* prod(exp(-ATT .* repmat(t_, 1, size(INC, 1))))';
plot(1:size(spectrum, 1), LAMBDA, '.-r'); hold on;
return;



attenuation = exp(-prop1 * d .* ATT(1, :))' .* exp(-(1 - prop1) * d * ATT(2, :))';

plot(x, y, '.-b');

