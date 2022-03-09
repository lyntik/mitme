function [thicks] = calc_thicknesses(INC, M, ATT, binBorder, Rij)


thicks = zeros(size(ATT, 1), 1);

minz = realmax;

if (size(ATT, 1) == 1)

    X = sum(M);
    
    for t = 0:0.0005:100
        LAMBDA = sum(INC .* prod(exp(-ATT .* repmat(t, 1, size(INC, 1))), 1)');
        z = abs((X - LAMBDA) / sqrt(LAMBDA));
        
        if (z < minz)
            minz = z;
            thicks = t;
        end
        
        if (z > minz)
            break;
        end
    end
    
    
elseif (size(ATT, 1) == 2)    
    
%     if ~exist('spaces', 'var') || size(spaces, 1) < 2
%         return;
%     end
    
%     space1 = spaces(1);
%     space2 = spaces(2);

    % apriory info
    %space1 = 0;
    %space2 = 1;
%     space1 = 0:0.001:0.3;
%     space2 = 0.0:0.001:1.2;
    
    space1 = 0:0.003:1;
    space2 = 0:0.002:0.38;
    %space2 = 00;
%      space1 = 0.5;
%      space2 = 0;
%      space1 =  0.469;
%      space2 = 0.043;
    
    %space2 = 0.0:0.001:0.5;
    
    
    
    %total = 0.188 + 0.032;
    
    %%%
    
    measure_spectrum = true;
    if (~isempty(Rij))
        measure_spectrum = false;
    end
    
    %binBorder = idivide(int32(size(INC, 1)), 2);
    %binBorder = 8;
    %binBorder = [11];
    %binBorder = [3 4 6 10];
    %binBorder = 2:2:9;
    
    n = size(binBorder, 2) + 1;
    
%     if (measure_spectrum)
%         %XBINS = ([sum(M(1:binBorder(1)), 1); sum(M(binBorder(1)+1:size(M, 1)), 1); ])
%         XBINS = borderSum(M, binBorder);
%     else
%         %XBINS = M;
%         XBINS = borderSum(M, binBorder);
%     end

    
    %XBINS = M;
    %M = M(2:size(M, 1) - 1);
    UpperBound = find(M == realmax);
    M = M(1:UpperBound(1) - 1);
    
    if (n == length(M) )
        XBINS = M;
    else
        XBINS = borderSum(M, binBorder);
    end
        
    
    
%     if (exist('total', 'var'))
%         for t1 = 0:0.0001:total
%             t2 = total - t1;
%             if (exist('Rij', 'var'))
%                 z = calc_z(INC, ATT, binBorder, XBINS,  t1, t2, Rij);
%             else
%                 z = calc_z(INC, ATT, binBorder, XBINS,  t1, t2);
%             end
%             if (z < minz)
%                 minz = z;
%                 thicks(:) = [t1; t2];
%             end
%         end
%     else
        D = zeros(1, size(Rij, 1));

        for t1 = space1
            for t2 = space2
                
                LAMBDA = INC .* prod(exp(-(ATT .* repmat([t1; t2], 1, size(INC, 1)))), 1)';
                if (~measure_spectrum)
                    %LAMBDA = LAMBDA' * Rij';
                    
                    
                    D(:) = 0;
                    for i = 1:size(D, 2)
                        for j = 1:size(LAMBDA, 1)
                            D(i) = D(i) + LAMBDA(j) * Rij(i, j);
                        end
                    end
                    LAMBDABINS = borderSum(D, binBorder);
                else
                    LAMBDABINS = borderSum(LAMBDA, binBorder);
                end
                %LAMBDA = LAMBDA(1:size(LAMBDA, 1) - 1);
                

%                 if (measure_spectrum)
%                     %LAMBDABINS = ([sum(LAMBDA(1:binBorder(1)), 1); sum(LAMBDA(binBorder(1)+1:size(LAMBDA, 1)), 1); ]);
%                     LAMBDABINS = borderSum(LAMBDA, binBorder);
%                 else
%                     LAMBDA = LAMBDA' * Rij';
%                     %LAMBDABINS = ([sum(LAMBDA(1:binBorder(1)), 2); sum(LAMBDA(binBorder(1)+1:size(LAMBDA, 2)), 2); ]);
%                     LAMBDABINS = borderSum(LAMBDA, binBorder);
%                 end
%                 

                
                %LAMBDABINS = [sum(LAMBDA(1:binBorder(1)), 2); sum(LAMBDA(binBorder(1)+1:binBorder(2)), 2); sum(LAMBDA(binBorder(2)+1:size(LAMBDA, 2)), 2); ];
                

                z = 0;
                for b=1:n
                    %power(XBINS(b) - LAMBDABINS(b), 2) / LAMBDABINS(b);
                    z = z + power(XBINS(b) - LAMBDABINS(b), 2) / LAMBDABINS(b);
                    %fprintf('%.4f; ', power(XBINS(b) - LAMBDABINS(b), 2) / LAMBDABINS(b));
                    
                    %z = z + abs(XBINS(b) - LAMBDABINS(b));% / LAMBDABINS(b);
                    %fprintf('%.4f; ', abs(XBINS(b) - LAMBDABINS(b)) / LAMBDABINS(b));
                    
                    %z = z + power((XBINS(b) - LAMBDABINS(b)) / LAMBDABINS(b), 2);
                end
                z = z / n;
                z = power(z, 0.5);

%                 if (exist('Rij', 'var'))
%                     z = calc_z(INC, ATT, binBorder, XBINS,  t1, t2, Rij);
%                 else
%                     z = calc_z(INC, ATT, binBorder, XBINS,  t1, t2);
%                 end                
                if (z < minz)
                    minz = z;
                    thicks(:) = [t1; t2];
                end
            end
        end
    end
          
    %minz

end




    
    
