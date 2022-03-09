
function f=modelResponse(spectrumRange, depositionRange, type, a1, c1, tailLevel, inaccuratePerc)

if (nargin < 7)
    inaccuratePerc = 0;
end

thr = 0;

spectrumRangep = int64(round(spectrumRange * 1000));
depositionRangep = int64(round(depositionRange * 1000));

n = size(spectrumRange, 2);
dn = size(depositionRange, 2);
Rij = zeros(dn, n);

typestr = string(type);

if typestr == 'Gaussian'

    for j = spectrumRange

        c = c1;
        
%         if (c1 == 100)
% %             if (j < 40) c = 2.8;
% %             %elseif (j < 40) c = 3.2;
% %             else c = 3.5; 
% %             end
%                 
%             % c = j * 0.2;
%             c = 0;
%              
%             if (j < 40) c = c + 2.8;
%             %elseif (j < 40) c = 3.2;
%             else c = c + 3.5; 
%             end             
%              
% %             if (j > 30 ) c = c + 2; end
% %             if (c < 0 ) c = 1; end
%         end
%         
%         if (c1 == 200)
% %             if (j < 30) c = 2.8;
% %             else c = 3.2;
% %             end
%                 
%             %c = j * 0.3;
%             c = 3;
%         end
        
        summ = 0;
        for i = depositionRange
            summ = summ + gauss0(a1, j, c, i, thr);
        end
        
        for i = depositionRange
            v = gauss0(a1, j, c, i, thr);
            Rij(findp(depositionRangep, i), findp(spectrumRangep, j)) = v / summ;
        end  

    end

elseif typestr == 'TailedGaussian'
    
    for j = spectrumRange

        summ = 0;
        for i = depositionRange
            g = gauss0(a1, j, c1, i, thr);
            if (g < tailLevel && i < j) 
                summ = summ + tailLevel;
            else
                summ = summ + gauss0(a1, j, 5, i, thr);
            end
        end


        for i = depositionRange
            g = gauss0(a1, j, c1, i, thr);
            if (g < tailLevel && i < j) 
                v = tailLevel;
            else
                v = gauss0(a1, j, c1, i, thr);
            end        

            Rij(findp(depositionRangep, i), findp(spectrumRangep, j)) = v / summ;
        end  
        
    

    end
    
else
    disp('modelResponse - Unknown type!');
end



if inaccuratePerc ~= 0

    perc = inaccuratePerc * 0.01;

    for j = spectrumRange
        afl = Rij(:, findp(spectrumRangep, j));

        summ = 0;
        for i = 1:size(afl, 1)
            afl(i) = afl(i) + ((afl(i) * perc * 2) * rand(1, 1) - afl(i) * perc);
            summ = afl(i) + summ;
        end
        for i = 1:size(afl, 1)
            afl(i) = afl(i) / summ;
        end        
        
        Rij(:, findp(spectrumRangep, j)) = afl;
    end
end




f = Rij;
    

end



