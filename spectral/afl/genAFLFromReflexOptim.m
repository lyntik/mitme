function [Rij, photonsCount, photonRate] = genAFLFromReflexOptim(energies, path, cdd, energyOffset, cropPixel, cropCard, energydiff)

colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };
colorIndex = 1;



load(sprintf('c:/work/acquisition/optim/%d', energies(size(energies, 2))), 'integral');
y = zeros(size(integral, 3) - 1, 1);
Rij = zeros(size(y, 1), size(energies, 2));

index = 1;

for energy = energies
    
    load(sprintf('c:/work/acquisition/optim/%d', energy), 'integral');
    
    y(:) = 0;
    
    summprev = -1;
    
    for i = 0:size(integral, 3)-1
    
        cropSizeScale = 1;
        cropSize = reflex_geom_part(energy + energyOffset, cdd, 2) * cropSizeScale;
    
        center = size(integral, 2) / 2 + 1;
        xfrom = center - round(cropSize / 2);
        xto = center + round(cropSize / 2);   
        
        if exist('cropPixel', 'var') && cropPixel ~= -1000
            %center
            %cropPixel
            xfrom = center + cropPixel;
            xto = center + cropPixel;
        elseif exist('cropCard', 'var')
%             xfrom = center - reflex_geom_part(energy + energyOffset, cdd, cropCard(index, 1));
%             xto = center + reflex_geom_part(energy + energyOffset, cdd, cropCard(index, 2)); 
%             
                pix = reflex_geom_part(energy + feval(energydiff, energy), cdd, abs(cropCard(index, 1)));
                if (cropCard(index, 1) < 0 )
                    x1 = center - pix;
                else
                    x1 = center + pix;
                end
                pix = reflex_geom_part(energy + feval(energydiff, energy), cdd, abs(cropCard(index, 2)));
                if (cropCard(index, 2) < 0 )
                    x2 = center - pix;
                else
                    x2 = center + pix;
                end
                
                if (x1 > x2)
                    xfrom = x2;
                    xto = x1;
                else
                    xfrom = x1;
                    xto = x2;
                end                   
        end
        
        %xto = xfrom;
        %xfrom = xto;
        
%         xfrom = center;
%         xto = center;
        
 
        
    
        summ = sum(sum(integral(:, int32(xfrom):int32(xto), int32(i+1)), 1), 2);
        %summ = sum(sum(integral(:, 1:2, int32(i+1)), 1), 2);
    
        if (i ~= 0)
            y(i) = y(i) + summprev - summ;
        end

        summprev = summ;
    end
    
    Rij(:, index) = y ./ sum(y);
    index = index + 1;
    
end

photonsCount = 0;
photonRate = 0;

    