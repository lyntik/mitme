function[offset] = offsetByIncidenceAngle(scd, crystallAngle, startAngle)
% 
% if (startAngle < 0)
%     startAngle = abs(startAngle);
%     angle1 = 180 - ((180 - startAngle) + crystallAngle);
%     offset = scd * sin( rad(angle1) ) / sin( rad(180 - startAngle) );
% else
%     angle1 = 180 - (180 - crystallAngle) - startAngle;
%     offset = scd * sin( rad(angle1) ) / sin( rad(startAngle) );
% end

if (startAngle < 0)
    startAngle = abs(startAngle);
    angle1 = 180 - ((180 - startAngle) + (90 - crystallAngle));
    offset = scd * sin( rad(angle1) ) / sin( rad(180 - startAngle) );
else
    angle1 = 180 - (90 + crystallAngle) - startAngle;
    offset = scd * sin( rad(angle1) ) / sin( rad(startAngle) );
end

