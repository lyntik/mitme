

projection0 = table2array(readtable('data/proj0.txt'));
projection1 = table2array(readtable('data/proj1.txt'));

w = size(projection0, 2);
h = 7;
projsNum = size(projection0, 1) / h;
projsToProcess = projsNum;


projr0 = zeros(h * projsNum, w);
projr1 = zeros(h * projsNum, w);

INC = modelSpectrum(19:40, 20000, 30, 20);
Rij = modelResponse(19:40, 19:40, 'Gaussian', 80, 3, 20);

ATT = loadAttenuation({'al', 'i'}, 19:40);

tic

for proj = 1:projsToProcess
    for row = 1:h
        for col = 1:w
            t1 = projection0((proj - 1) * h + row, col);
            t2 = projection1((proj - 1) * h + row, col);
            
            D = generateDetectedMeasurement([t1; t2 ], INC, ATT, Rij, 4);
            D = poissrnd(D);

            %return;l

            %[f] = decomp(INC, ATT, Rij, D)
            [f] = straight_decomp2(INC, ATT, Rij, D, 0.002, [0.65 0.065]);
            
            
            projr0((proj - 1) * h + row, col) = f(1);
            projr1((proj - 1) * h + row, col) = f(2);
            
            %projr0((proj - 1) * h + row, col) = D(2);

            %col
        end
        
        
    end
    proj
end

toc

return;

fileID = fopen('data/projr0.txt','w');
%for col = 1:w
%    fprintf(fileID, 'column_%d ', col - 1);
%end
%fprintf(fileID, '\n');

for proj = 1:projsToProcess
    for row = 1:h
        for col = 1:w
            fprintf(fileID, '%.4f ', projr0((proj - 1) * h + row, col));
            if (col == w && (row ~= h || proj ~= projsToProcess))
                fprintf(fileID, '\n');
            end
        end
    end
end

fclose(fileID);

%return;

fileID = fopen('data/projr1.txt','w');
%for col = 1:w
%    fprintf(fileID, 'column_%d ', col - 1);
%end
%fprintf(fileID, '\n');
 
for proj = 1:projsToProcess
    for row = 1:h
        for col = 1:w
            fprintf(fileID, '%.4f ', projr1((proj - 1) * h + row, col));
            if (col == w && (row ~= h || proj ~= projsToProcess))
                fprintf(fileID, '\n');
            end
        end
    end
end

fclose(fileID);


%fprintf(fileID,'%6s %12s\n','x','exp(x)');
%fprintf(fileID,'%6.2f %12.8f\n',A);






