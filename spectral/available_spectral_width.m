function available_spectral_width(path, energy)
    
    ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, energy, 0, 'test15.txt')), 'VarNames', {'11'});
    dd = str2num(char(ds.x11));

    [left, right] = reflex_boundaries(dd, 150);
    
    right - left

end