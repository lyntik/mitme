%%% this for calc plane angle. angleFromFocus is more convenient name
%%% crystall angle is unnecessary

% function[angle1] = angleFromCenter(braggCenter, crystallAngle, bragg)
% if (bragg > braggCenter)
%     angle1 = 180 - (90 - crystallAngle) - (180 - bragg);
% else
%     angle1 = 180 - (90 + crystallAngle) - bragg;
% end

function[angle1] = angleFromCenter(braggCenter, crystallAngle, bragg)
if (bragg > braggCenter)
    angle1 = 180 - braggCenter - (180 - bragg);
else
    angle1 = 180 - (180 - braggCenter) - bragg;
end
 
