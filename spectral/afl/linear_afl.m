%function [ynorm] = linear_afl(energy)


%path = '//192.168.0.105/work/politeh/thrscan/bias200clock16';
path = 'c:/work/acquisition/orig/bias200clock16';

figure(2);

%energies = [ 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 38 40 42 44 46 48 50 ];
energies = [ 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 ];

Rij = zeros(afl_bins_number(path, energies(size(energies, 2))), size(energies, 2));

index = 2;

for energy = 21 %energies
    
    energy

    colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };
    colorIndex = 1;

    [left, right] = reflex_boundaries_e(path, energy, 150);
    geom_len = right - left + 1;

    ynorm = zeros(afl_bins_number(path, energy), 1);

    %for pix = geom_len/2:-1:-geom_len/2
    k = 1;
    for pix = cropTable(index, 1):-1:cropTable(index, 2)

        [RijPx, photonsCount, photonRate] = genAFLFromReflexOptim(energy, ...
            path, ...
            480, ...
            0, ...
            pix);
        
        if (mod(k, 8) == 0)
            plot(16:2:16+2*(size(RijPx, 1)-1), RijPx(:,  1), char(colors(colorIndex)), 'DisplayName', sprintf('%d pix %.2f', energy, pix)); hold on;
            colorIndex = colorIndex + 1;
            if (colorIndex == 8)
                colorIndex = 1;
            end
        end

        ynorm = ynorm + RijPx(:, 1);
     
%         for e = 1:size(Rij, 2)
%             plot(16:2:16+2*(size(Rij, 1)-1), Rij(:,  e), char(colors(colorIndex)), 'DisplayName', sprintf('%d', i)); hold on;
%             colorIndex = colorIndex + 1;
%             if (colorIndex == 8)
%                 colorIndex = 1;
%             end
%         end
        k = k + 1;

    end    
    
        
    
    Rij(:, index) = [ynorm ./ sum(ynorm); zeros(size(Rij, 1) - size(ynorm, 1), 1 ) ];
    index = index + 1;
    
end    

title('AFLs for monolines (column) of +-21kEv');
legend('show');
    
RijNew = Rij;

    %i = 1;

    % [Rij, photonsCount, photonRate] = genAFLFromReflexOptim(energy, ...
    %     path, ...
    %     480, ...
    %     0, ...
    %     -1000);

    %plot(16:2:16+2*(size(ynorm, 1)-1), ynorm, char(colors(colorIndex)), 'DisplayName', sprintf('%d', i)); hold on;
    %plot(16:2:16+2*(size(ynorm, 1)-1), Rij(:, 1), char(colors(colorIndex + 1)), 'DisplayName', sprintf('%d', i)); hold on;




