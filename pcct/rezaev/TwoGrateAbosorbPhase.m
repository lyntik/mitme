function  [ Cres ] = TwoGrateAbosorbPhase(g1,g2,Da,la,kk,zmin,zmax)

%% plane monochromatic wave goes throught two grating
% first grate - the absorb grate :
%                   g1.a - aperture size,
%                   g1.d - size of opaque plate
%                   g1.N - number of slits
%                   g1.type=1, if it is absorb grate 
% second grate(phase grate) is situated at the distanse Da and caracterised by a2,d2,N2
%                   g2.a - aperture size,
%                   g2.d - size of opaque plate
%                   g2.N - number of slits
%                   g2.type=0, if it is absorb grate 
% la - wave length
% kk - wave number
% zmin - minimal distanse after second grid  
% zmax - 
% electric field C at the distance Da after absorbtion grate
% for clear understanding, we  
global x nz;
zstep=(zmax-zmin)/nz;
if g1.type==1 && g2.type==0% 1-absorb grate, 2 - phase grate
    C=AbosorbGrate(g1.a,g1.d,g1.N,la,kk,0.5,Da);
    PlotSlitX(g2.a,g2.d,g2.N,Da);
    %intencity I=|C|^2, phase=arg(C);
    T=exp(1i*g2.phi.*SlitX(x,g2.a,g2.d,g2.N));% phase grate at the 
    k=1;

   
    for z=Da+zmin:zstep:Da+zmax

        P=1/(1i*la*(z))*exp(-1i*pi*x.^2/(la*z))*exp(-1i*kk*z);%transmittance function in the free space

        Cres(k,:)=conv(C(end,:).*T,P,'same');
        k=k+1;
    end
else% 1 - phase grate, 2-absorb grate, 
    [C] = PhaseGrate(g1.a,g1.d,g1.N,phi,la,kk,0,Da);
                   
    PlotSlitX(g1.a,g1.d,g1.N,Da);
    u1=SlitX(x,g2.a,g2.d,g2.N);
    k=1;
    for z=zmin:zstep:zmax
        h=1i/(la*z)*exp(-1i*kk*z)*exp(-1i*kk*(x.^2)/(2*z));
        Cres(k,:)=conv(C(end,:).*u1,h,'same');
        k=k+1;
    end
end


     DrawInt(Cres,g2.a,g2.d,g2.N,zmin,zmax,zstep,x);
     title(['Intencity after 2 grates, z_t=',num2str(2*g2.a^2/la)]);
end
