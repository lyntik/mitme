function [x] = reflex_geom_part(e, cdd, required_spectral_width )

bragg_rad = asin(12.4 / (2.72 * e));

Q = required_spectral_width / (e * cot(bragg_rad));

x = cdd * sin(Q / 2) * 2;

    




