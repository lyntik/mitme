function []=PlotSlitX(a,d,N,zmin)  
% PlotSlitX функция фотображающая дифракционную решетку на расстоянии zmin 

%  параметры дифракционной решетки:
%  a - ширина щели
%  d - расстояние между щелями
%  N - количество щелей


 if N==1
  p0=plot([zmin,zmin],[-a/2,a/2],'.-y');
  p0.LineWidth=4;
 else
     for i=0:N/2
        p1=plot([zmin,zmin],[-a/2+i*(a+d),a/2+i*(a+d)],'.-y');
        p2=plot([zmin,zmin],[-a/2-i*(a+d),a/2-i*(a+d)],'.-y');
        p1.LineWidth=4;
        p2.LineWidth=4;
        
         p3=plot([zmin,zmin],[a/2+i*(a+d),a/2+i*(a+d)+d],'.-b');
         p4=plot([zmin,zmin],[-a/2-i*(a+d),-a/2-i*(a+d)-d],'.-b');
         p3.LineWidth=4;
         p4.LineWidth=4;
     end
 end

end
