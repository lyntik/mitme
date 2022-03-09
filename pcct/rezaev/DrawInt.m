function[]=DrawInt(C,a,d,N,zmin,zmax,zstep,x)
% DrawInt ���������� ������������� ������������� �� ������������� ��������

% ������� ���������:
%  ��������� ������������� �������(������� �����������):
%  a - ������ ����
%  d - ���������� ����� ������
%  N - ���������� �����
% [zmin,zmax] - ���������� �� ������������� ������� �� ������� �������������� ������������� �������������
% zstep  - ��� �� ��� OZ, ����������� ��� ����������� ��������������
% ���������  ��  ��������� [zmin,zmax] (��� OZ  ����������� ��������������� ������������� �������)
% x -  ������� ����������� ������������� ������� (������� ���������������  � ������, ������������ �������� x ) 


figure();
     set(gcf, 'Position', get(0,'ScreenSize'));
     hold on;
     [zz,xx]=meshgrid(zmin:zstep:zmax,x);
     surf(zz,xx,abs(C(:,:)'),'MeshStyle','none'); %1:3:end
     
     %surf(zz,xx,angle(C(:,:)'),'MeshStyle','none');
     colormap jet;
     xview=a/2+min(N/2,2)*(a+d);
     axis([zmin zmax -xview xview]); %zmin zmax -xview xview]); 

     PlotSlitX(a,d,N,zmin);
     xlabel('z,m');ylabel('x,m');
     %title(['Absorbtion grate, z_t=',num2str(2*a^2/la)]);
     view(2);
     
end