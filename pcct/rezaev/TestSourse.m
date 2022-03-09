close all;



i=1;
for n=[5, 10]
    for z=[0.005, 0.01, 0.1, 0.2]
        
        [diff,N]=Sourse(z,n);
        res(i,:)=[N,z,diff];
        i=i+1;
      
    end
end

array2table(res,'VariableNames',{'Sourse_Nnumber' 'Z_Distanse' 'Differense'})


 






