close all;

E=[22e+3,60e+3] ;%��,  ������ �������  ��������� 

for i=1:2
    [ g0,g1,g2,la,kk ] = GrateParameters( E(i) );   % ������������� ���������  ���� ������� ��� ������� ��������������

    dla=0.1*la;                                     % ������ ������ ������� ���������  ��� ������������ ������ �������������������� ���������




     %% phase grate

        PhaseGrate(g1.a,g1.d,g1.N,g1.phi,la,kk,0.1,1);              % ������������ �������������, ��� ����������� ������� ����� ����� �������������  ������� ������� 
        savefig(['resPhase/zmin_',num2str(0),'_zmax_',num2str(1)]); % ���������� ��������� � ���� � �������������� ��������� ������� rezPhase 

        for zmin=1:1:10                                              % ������������ �������������, ��� ����������� ������� ����� ����� �������������  ������� ������� 
                                                                     % ����������� �� ���������� zmin
            zmax=zmin+5;
            PhaseGrate(g1.a,g1.d,g1.N,h1.phi,la,kk,zmin,zmax);
            savefig(['resPhase/zmin_',num2str(zmin),'_zmax_',num2str(zmax)]);

        end


    %% absorbtion grate nonmonochromatic wave
     zmin=0.1; zmax=1;
     AbsorbGrateNonmonoch( g0.a,g0.d,g0.N,la,dla,kk,zmin,zmax );            % ������������ �������������, ��� ����������� ������� ������������������� ����� ����� �������������  ������� ������� 
     savefig(['resAbsorb/nonmonoch_zmin_',num2str(0),'_zmax_',num2str(1)]); % ���������� ��������� � ���� � �������������� ��������� ������� rezAbsorb 


    %% monochromatic wave with la   
         AbosorbGrate(g0.a,g0.d,g0.N,la,kk,zmin,zmax);                      % ������������ �������������, ��� ����������� ������� ����� ����� ������������� ����������� �������
        savefig(['resAbsorb/zmin_',num2str(zmin),'_zmax_',num2str(zmax)]);  % ���������� ��������� � ���� � �������������� ��������� ������� rezAbsorb 

    for zmin=1:1:10

        zmax=zmin+5;
        AbosorbGrate(a,d,N,la,kk,zmin,zmax);
        savefig(['resAbsorb/zmin_',num2str(zmin),'_zmax_',num2str(zmax)]);

     end
    %% plate monochromatic wave goes throught two grating
    % absordb grate parameters: a,d,N
    % 
    % d2=(g1.a*2)^2/(2*la);% Talbot distanse
    % zmin=d2;zmax=d2+1;
    % 
    % Cres=TwoGrateAbosorbPhase(g0,g1,d2,la,kk,zmin,zmax);


    %% Intencity before G0
    s.Ns=100;       % ���������� �������� ���������� 
    s.size=0.0005;  % ������������� ���������� �� ������� [-size/2,size/2]
    d0=0.1;         % ���������� �� ������� ������������� ����� �����

    Ures=G0Grate(s,d0,kk); % ������� ��������� ������ �� ���������� d0  �� ������������ ���������
    savefig(['ExtendSourse_d_',num2str(d0)]);
    %% Intensity after G0 - absordb grate 


    zmin=d0;zmax=d0+0.15;

    Cres=IntAftG0(g0,s,kk,la,d0,zmin,zmax);     % �������� ����� �� ���������� [zmin,zmax]  �� ������� G0 ������������� �� ���������� d0
    savefig(['ExtendSourseG0_zmin_',num2str(zmin),'_zmax_',num2str(zmax)]);
    %% Intensity with three gtate and random phase


    d0=10;               % ���������� �� ��������� ��  ������ ������� G0  
    d2=(g1.a*2)^2/(2*la);% ���������� �� ��������� ��  ������  ������� G1  
    d1=g0.a*d2/g2.a;     % ���������� �� ��������� ��  ������ ������� G2  


    IntThreeGrate(g0,g1,g2,d0,d1,d2,s,kk,la); % ��������� ������ ������� ��������������
end





