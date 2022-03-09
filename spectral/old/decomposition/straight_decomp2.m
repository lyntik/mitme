function f=straight_decomp2(INC, ATT, Rij, D, step, searchLimits)

f = zeros(2, 1);

n = 4;

minz = realmax;


for t1 = 0:0.0025:searchLimits(1)
    for t2 = 0:0.0005:searchLimits(2)
        
        LAMBDA = generateDetectedMeasurement([t1; t2], INC, ATT, Rij, n);
        
        z = 0;
        for b=1:n
            z = z + power(D(b) - LAMBDA(b), 2) / LAMBDA(b);
        end
        z = z / n;
        z = power(z, 0.5);
        
        if (z < minz)
            minz = z;
            f(1) = t1;
            f(2) = t2;
        end
      
    end
end

