
function [ diff, N ] = Sourse(zd,n)
%SOURSE  function

% input parameters
% z   distanse from the sourse center 
% n+1 sourses at the minimal side of ox,oy

% output parameters 
% diff - module of maximal  differense
% N - sourse numbers

 

%% lets consider these suggestions

zf=0.2;     % distanse of sourse for normalization  
alpha=0.2;  % size of square plate for normalization
a=4*10^(-4);% size of extended sourse in ox direction
b=2*10^(-4);% size of extended sourse in oy direction
la=10^(-8); % wave length
k=2*pi/la;
   
%%

h=figure;

    %% point sourse
    fun = @(x,y)1./ (zf.^2+x.^2+y.^2);
    q=integral2(fun,-alpha,alpha,-alpha,alpha);
    % normalization coefficient( at the square plate, sized [-alpha,alpha] along OX and [-alpha,alpha] along OY at the distanse zf
    E0=1/sqrt(q);
    % square intensity
    IntP3D2=@(z,x,y) E0^2./(z.^2+x.^2+y.^2);
    
    %% intensity distribution for point sourse 
    close all;
    hold on;
    grid on;
    ps=subplot(1,3,1);

    [x,y]=meshgrid(-0.2:0.01:0.2, -0.2:0.01:0.2);
    surf(x,y,IntP3D2(zd,x,y));title('|I(x,y)|^2 for point sourse','Color','b')
    colormap(ps,autumn(5));
    xlabel('x','FontSize',12,'FontWeight','bold','Color','b');
    ylabel('y','FontSize',12,'FontWeight','bold','Color','b');
    zlabel('|I(x,y)|^2','FontSize',12,'FontWeight','bold','Color','b');
    hold off;
    %% extended sourse of size [-a,a] along OX and [-b,b] along OY
    % it consists of N point sourses,which are equidistant 
    
    
    %normalization
    IntE3D2(0,0,0.2);
    f=@(x,y)IntE3D2(x,y,zf);
    %1/q - normalization coefficient( at the square plate, sized (-alpha,alpha) at the distanse zf)
    q=integral2(f,-alpha,alpha,-alpha,alpha);
    % square intensity
    intf=@(x,y)IntE3D2(x,y,zd)/q;
    
    %% intensity distribution for extended sourse 
    subplot(1,3,2);
    surf(x,y,intf(x,y));
    title('|I(x,y)|^2 for extended sourse','Color','b');
    xlabel('x','FontSize',12,'FontWeight','bold','Color','b');
    ylabel('y','FontSize',12,'FontWeight','bold','Color','b');
    zlabel('|I(x,y)|^2','FontSize',12,'FontWeight','bold','Color','b');
     %% differens of intensity distribution for both sourses 
     subplot(1,3,3);
     hold on;
     grid on;
     
     
     % differense diff=||Ip(x,y)|^2-|Ie(x,y)|^2|  
     diff=max(max(abs(intf(x,y)-IntP3D2(zd,x,y))));
          
     title(['|diff|=',num2str(diff) ,' (y=0)'],'Color','b');
     xlabel('x','FontSize',12,'FontWeight','bold','Color','b');
     ylabel('|I(x,0)|^2','FontSize',12,'FontWeight','bold','Color','b');
     
     xx=-alpha:0.01:alpha; 
     plot(xx,intf(xx,0),'-*r');
     plot(xx,IntP3D2(zd,xx,0),'--ob');
     legend('point','extend');

     hold off;
     
    
     savefig(['RESULT/z=',num2str(zd),' N=',num2str(N),'.fig']);
    



    function I = IntE3D2(x,y,z)
        % |I(x,y)| for the  extended sourse from N point sourses, which are equdistant 
    delta=2*min(a,b)/n;% distanse beetwen sourses
    xi=-a:delta:a;% sourse position along OX
    yi=-b:delta:b;% sourse position along OY    
    N=length(xi)*length(yi);% number of point sourses
    
    I=0;% |I(x,y)|^2 where we set E0=1
    for j=1:length(yi)
        for i=1:length(xi)
            I=I+1./(N*(z.^2+x.^2+y.^2+xi(i)^2+yi(j)^2-2*(x*xi(i)+y*yi(j)))); 
        end
    end
    end    

end
   




