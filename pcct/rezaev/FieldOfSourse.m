function Ures=FieldOfSourse(s,d0,kk)
% FieldOfSourse  рассчитывает уравнение воны на расстоянии d  от центра
% протяженного источника
% Входные параметры:
% s.Ns - количество точечных источников, равномерно расположенных на отрезке [-s.size/2,s.size/2]
% s.size - размер протяженнного size of the extendeed sourse 
% d0 - расстояние детектирования волны
% kk -  волновое число
% Выходные параметры:
% Ures - плоская волна, полученная в результате излучения  протяженного источника


global n x ;

if s.Ns==1
    ds=s.size;
else
    ds=s.size/(s.Ns-1);% distanse between sourses
end


Ures=zeros(1,n);
phi=zeros(1,s.Ns);%rand(1,s.Ns)*2*pi;
for j=1:n
    for i=1:s.Ns
        if s.Ns==1
            r=sqrt((x(j))^2+d0^2);
        else
            r=sqrt((-s.size/2+(i-1)*ds-x(j))^2);%+d0^2);
            
        end
        Ures(j)=Ures(j)+Usp(phi(i),r);
    end
    
end

%close all;
figure;
subplot(2,1,1);
plot(x,abs(Ures),'-r');title (['Intensity before G0 grate at z=',num2str(d0)]);
subplot(2,1,2);
plot(x,angle(Ures),'-r');title ('phase');



function U=Usp(phi,r)  % уравнение сферической волны
     U=(1/r)*exp(-1i*kk*r+1i*phi);
end

end

