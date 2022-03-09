
e = 6.4472;
e_center = e;
bragg_from = asin(12.4 / ((e - 0.5) * 2.72) ) * 180 / pi;
bragg_to = asin(12.4 / ((e + 0.5)  * 2.72) ) * 180 / pi;

bragg_center = asin(12.4 / ((e ) * 2.72) ) * 180 / pi;

scd = 50;
crystallAngle = 45;
cdd = 50;

%angle = angleOfIncidence(scd, crystallAngle, -1)

%return;


%calcReduceFactorByAngle(bragg_from, bragg_to, 0.001)
%calcReduceFactorByEnergy(e_center - 0.5, e_center + 0.5, 0.1)

% steps = 0.1:-0.0001:0.001;
% factors = size(size(steps,2), 1);
% i = 1;
% for step = 0.1:-0.0001:0.001
%     factors(i) = calcReduceFactorByAngle(scd, crystallAngle, bragg_from, bragg_to, step);
%     i = i + 1;
% end
% 
% plot(steps, factors, '.-b');
% xlabel('Step, degrees');
% ylabel('Reduce factor');
% title('Diffraction intensity reduce factor VS bragg angle sampling step ');

% 
% steps = 0.1:-0.0001:0.001;
% factors = size(size(steps,2), 1);
% i = 1;
% for step = 0.1:-0.0001:0.001
%     factors(i) = calcReduceFactorByEnergy(e_center - 0.5, e_center + 0.5, step);
%     i = i + 1;
% end
% 
% plot(steps, factors, '.-b');
% xlabel('Step, degrees');
% ylabel('Reduce factor');
% title('Diffraction intensity reduce factor VS energy sampling step ');
% 
%return;


%%% new
% 
bragg = bragg_from;
c = offsetByIncidenceAngle(scd, crystallAngle, -bragg);

angle1 = 180 - (90 - crystallAngle);
b = sqrt( c^2 + cdd ^2 - c* cdd * cos(rad(angle1)) );

%%%
angle2 = asin( sin(rad(angle1)) * cdd / b ) * 180 / pi;
angle3 = 180 - angle2 - angle1;

angle2_1 = 90 - angle3;
angle2_2 = bragg - angle2;
angle2_3 = 180 - angle2_1 - angle2_2;

r1 = b * sin(rad(angle2_2)) / sin(rad(angle2_3))


angle1 = 180 - bragg_to;
angle3 = asin(c * sin(rad(angle1)) / cdd) * 180 / pi;
angle2 = 180 - angle1 - angle3;

angle2_1 = 90;
angle2_2 = (90 - crystallAngle) - angle2;
angle2_3 = 180 - angle2_1 - angle2_2;

r2 = cdd * sin(rad(angle2_2)) / sin(rad(angle2_3))



reflex_geom_part(e, cdd, 1)

% braggs = [];
% eFrom = e_center - 5;
% eTo = e_center + 5;
% e = eFrom;
% i = 1;
% while ((e + step) < eTo)
%     braggs(i) = asin(12.4 / ((e) * 2.72) ) * 180 / pi;
%      e = e + step;
%     i = i + 1;
% end
% 
% plot(1:i-1, braggs, '.-b');
% 
% return;
% 
% %%% angle
% 
% angles = [];
% i = 1;
% 
% eFrom = e_center - 0.5;
% eTo = e_center + 0.5
% 
% eprev = eFrom;
% e = eFrom;
% bragg = asin(12.4 / ((eFrom) * 2.72) ) * 180 / pi;
% angleprev = angleFromCenter(bragg_center, crystallAngle, bragg);
% 
% % by energy
% while ((e + step) < eTo)
%     e = e + step;
%     bragg = asin(12.4 / (e * 2.72) ) * 180 / pi;
%     angle = angleFromCenter(bragg_center, crystallAngle, bragg);
%     
%     angles(i) = abs(angle - angleprev);
%     i = i + 1;
%    
%     angleprev = angle;
% end
% 
% plot(1:i-1, angles, '.-b');




