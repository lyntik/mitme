function Ures=G0Grate(s,d0,kk)

% Входные параметры:
% s.Ns - количество точечных источников
% s.size - размер протяженного источника, на котором равномерно
% распределяются s.Ns точечных источников
% d0 - расстояние  от точечного источника на котором детектируется волна
% kk - волновое число

% Выходные параметры:
% Uzes - волна, на расстоянии d0 от точечного источника

global nz n x ;
%nz=100;
%la=1e-6;
%kk=2*pi/la;
%s.Ns =4;% sourse number 
%s.size=0.005;%sourse set at the length - size
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

close all;
figure;
subplot(2,1,1);
plot(x,abs(Ures),'-r');title (['Intensity before G0 grate at z=',num2str(d0)]);
subplot(2,1,2);

plot(x,angle(Ures),'-r');title ('phase');



function U=Usp(phi,r)  
     U=(1e+7)/r*exp(-1i*kk*r+1i*phi);
end

end

