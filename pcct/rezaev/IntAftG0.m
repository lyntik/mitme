function [C]=IntAftG0(g,s,kk,la,d0,zmin,zmax)
%IntAftG0 - ������������ ��������� ����� �� ���������� d0,  

% ������� ���������:
% s.Ns - ���������� �������� ����������
% s.size - ������ ������������ ���������, �� ������� ����������
% �������������� s.Ns �������� ����������

% kk - �������� �����
% la - ����� �����
% d0 - ����������  �� ��������� ���������  �� ������� G0 
% [zmin, zmax] - ���������� ����� ������� G0  �� ������� ������������� �����
% �������� ���������:
% C - �����, ����� ������� G0


global  nz x ;

%Ures=G0Grate(s,zmax,kk); C=Ures;
Ures=G0Grate(s,d0,kk);

zstep=(zmax-zmin)/nz;
u1=SlitX(x,g.a,g.d,g.N);% slit function
k=1;
 for z=zmin:zstep:zmax 
          
        h=1i/(la*z)*exp(-1i*kk*z)*exp(-1i*kk*(x.^2)/(2*z));%+y.^2
                
        C(k,:)=conv(h,Ures.*u1,'same');
        k=k+1;
 end
 

DrawInt(C,g.a,g.d,g.N,zmin,zmax,zstep,x);


    title(['Intensity agter G0']);
end
