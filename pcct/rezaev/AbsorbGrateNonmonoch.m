function [Cres ] = AbsorbGrateNonmonoch( a,d,N,la,dla,kk,zmin,zmax )

% Входные параметры:
%  параметры дифракционной решетки(решетка поглощающая):
%  a - ширина щели
%  d - расстояние между щелями
%  N - количество щелей
%  la - длина волны
% dla - половина ширины спектра длин волн
%  кк - волновое число
% [zmin,zmax] - расстояние от дифракционной решетки на котором рассчитывается распределение интенсивности

% Выходные параметры:
% Cres -  волна прошедшая через поглощающую дифракционную решетку 


global nz n x;

 Cres=zeros(nz+1,n);

 for kla=la-dla:dla/10:la+dla
    C=AbosorbGrate(a,d,N,kla,kk,zmin,zmax);
    Cres=Cres+C;
 end
   
 figure();
 set(gcf, 'Position', get(0,'ScreenSize'));
 hold on;

 zstep=(zmax-zmin)/100;

 [zz,xx]=meshgrid(zmin:zstep:zmax,x);
 surf(zz,xx,abs(C(:,:)'),'MeshStyle','none'); %1:3:end
 
 xview=a/2+N/2*(a+d);
 axis([zmin zmax -xview xview]); 
 
 PlotSlitX(a,d,N,zmin);
 xlabel('z,m');ylabel('x,m');title(['Nonmonochromatic wave,z_t=',num2str(2*a^2/la),'at la',num2str(la)])
 view(2);
 
end

