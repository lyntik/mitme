function [xpix] = reflex_geom_part(e, cdd, required_spectral_width )

%for e = 18:35

    %cdd = 200;
    %required_spectral_width = 1; %kEv

    bragg_rad = asin(12.4 / (2.72 * e));

    Q = required_spectral_width / (e * cot(bragg_rad));

    x = cdd * sin(Q / 2) * 2;
    xpix = round(x / 0.055);
    
    %fprintf('%d %.4f\n', e, xpix);
%    fprintf('mapX_[%d] = %d;\n', e, round(xpix));
%end




