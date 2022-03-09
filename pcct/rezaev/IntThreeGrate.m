function []=IntThreeGrate(g0,g1,g2,d0,d1,d2,s,kk,la)
% IntThreeGrate - ћодель “альбот интерферометра 

% ¬ходные параметры:
% g0, g1, g2 - параметры трех дифракционных решеток 
% d0, d1, d2 Ц рассто€ние от источника до первой, второй и третьей решетками
% s  Ц   параметры прот€женного источника
% kk Ц волновое число 
% la Ц длина волны


global nz x;

% after G0
[C]=IntAftG0(g0,s,kk,la,d0,d0,d0+d1);
plot(x,abs(C),'.-r');

% afer G1
    T=exp(1i*g1.phi.*SlitX(x,g1.a,g1.d,g1.N));% phase grate at the 
    zmin=d0+d1;zmax=d0+d1+d2;
    zstep=(zmax-zmin)/nz;
    k=1;
    for z=zmin:zstep:zmax
        P=1/(1i*la*(z))*exp(-1i*pi*x.^2/(la*z))*exp(-1i*kk*z); %transmittance function in the free space
        Cres(k,:)=conv(P,C(end,:).*T,'same');
        
        figure; plot(x,abs(Cres(k,:)),'-r');
        
        k=k+1;
    end
    
DrawInt(Cres,g1.a,g1.d,g1.N,zmin,zmax,zstep,x);
title('after G1 grate' )
%after G2(absorb)

u1=SlitX(x,g2.a,g2.d,g2.N);
zmin=d0+d1+d2;zmax=d0+d1+d2+1;
zstep=(zmax-zmin)/nz;    
k=1;
    for z=zmin:zstep:zmax

        h=1i/(la*z)*exp(-1i*kk*z)*exp(-1i*kk*(x.^2)/(2*z));

        Cres2(k,:)=conv(Cres(end,:).*u1,h,'same');
        k=k+1;
    end

DrawInt(Cres2,g2.a,g2.d,g2.N,zmin,zmax,zstep,x);
title('after G2 grate' )



end