function [angle, a] = angleOfIncidence(scd, crystallAngle, pointOfIncidence)

if (pointOfIncidence > 0)
    alpha = crystallAngle + 90;
else
    alpha = 90 - crystallAngle;
end
alpha_rad = alpha * pi / 180;
pointOfIncidence = abs(pointOfIncidence);

a = sqrt(scd ^ 2 + pointOfIncidence ^ 2 - 2 * scd * pointOfIncidence * cos(alpha_rad) );

angle = asin (scd * sin(alpha_rad) / a ) * 180 / pi;

