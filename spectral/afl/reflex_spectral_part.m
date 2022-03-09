function [spectral_width] = reflex_spectral_part(e, cdd, xpix)

%for e = 18:35

    %cdd = 200;
    %required_spectral_width = 1; %kEv

    bragg_rad = asin(12.4 / (2.72 * e));

    x = xpix * 0.055;
    Q = asin(x / (cdd * 2) ) * 2;
    
    spectral_width = e * Q * cot(bragg_rad);

    
    

