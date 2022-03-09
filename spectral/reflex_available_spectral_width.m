function [spectral_width] = reflex_available_spectral_width(path, energy, cdd, energyCorrected)
    
    ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, energy, 0, 'test15.txt')), 'VarNames', {'11'});
    dd = str2num(char(ds.x11));

    [left, right] = reflex_boundaries(dd, 150);
    
    if exist('energyCorrected', 'var')
        spectral_width = reflex_spectral_part(energyCorrected, cdd, right - left);
    else
        spectral_width = reflex_spectral_part(energy, cdd, right - left);
    end

end