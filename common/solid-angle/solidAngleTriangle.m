function solid=solidAngleTriangle(r1, r2, r3)

l1 = sqrt(dot(r1,r1));
l2 = sqrt(dot(r2,r2));
l3 = sqrt(dot(r3,r3));


solid = 2 * atan( dot(r1, cross(r2, r3)) / (l1 * l2 * l3 + dot(r1, r2) * l3 + dot(r2, r3) * l1 + dot(r3, r1) * l2 )  ) ;

end


