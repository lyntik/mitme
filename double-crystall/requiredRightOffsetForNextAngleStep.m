% step only negative

function [offset] = requiredRightOffsetForNextAngleStep(a, angle, step)

angle2 = angle + step;
angle1 = 180 - ((180 - angle) + angle2);

angle1_rad = angle1 * pi / 180;
angle2_rad = angle2 * pi / 180;

offset = a * sin(angle1_rad) / sin(angle2_rad);
