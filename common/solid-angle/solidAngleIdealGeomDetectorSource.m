function w=solidAngleIdealGeomDetectorSource(w, h, d)

%%% This function handles the partical case of ideal source/detector positions, i.e. central normal line intersects source. Thus, the following formula
%%% w = 4 * asin( (w * h) / sqrt((w^2 + 4*d^2)*(h^2 + 4*d^2)) )
%%% can be applied

%%% Just about "solid angle" subject:
%%% solidAngleTriangle() is base function for calculate solid angles for
%%% polygons. The only task is to define triangles in the right way.
%%% Here i use it for test.
%%%
%%% Another way (and more universal): calculate integral (don't know how to do at the moment =) )
%%%

w = 4 * asin( (w * h) / sqrt((w^2 + 4*d^2)*(h^2 + 4*d^2)) );

% r1 = [d -h / 2 w / 2];
% r2 = [d h / 2 w / 2];
% r3 = [d -h / 2 -w / 2];
% triangle1 = abs(solidAngleTriangle(r1, r2, r3));
% 
% 
% r1 = [d h / 2 -h / 2];
% r2 = [d h / 2 h / 2];
% r3 = [d -h / 2 -h / 2];
% triangle2 = abs(solidAngleTriangle(r1, r2, r3));
% 
% triangle1 + triangle2
% w2 = solidAngleTriangle(r1, r2, r3) + solidAngleTriangle(r3, r4, r1);
% 

end


