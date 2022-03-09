



       %P = phantom(128);
%       R = radon(P,0:179);
%       I1 = iradon(R,0:179);
%       I2 = iradon(R,0:179,'linear','none');
%       subplot(1,3,1), imshow(P), title('Original')
%       subplot(1,3,2), imshow(I1), title('Filtered backprojection')
%       subplot(1,3,3), imshow(I2,[]), title('Unfiltered backprojection')
%return

%function untitled = ToUntiltedCoordinateAtIsocenter(coord, sid, sdd, sx, px)

%ToUntiltedCoordinateAtIsocenter(-5, 100, 200, 0, 0);


%return


%delta = delta - 2 * pi * floor(delta / 2 * pi)
    
%     
%   //Delta
%   double delta = 0.5 * (lastAngle - firstAngle - vnl_math::pi);
%   delta = delta - 2*vnl_math::pi*floor( delta / (2*vnl_math::pi) ); // between -2*PI and 2*PI


%return;


% reading projections

disp('reading projections...');

[file, path] = uigetfile( {'*.csv','csv Files'}, 'Pick a csv file');
csvFile = strcat(path,file);

csvHandle = fopen(csvFile,'r'); % Open CSV file for reading
% Read data from csv file directly into cell array C
C = textscan( csvHandle,' %s %f %f %f %f %d','Delimiter', ',' );

projs.filenames = C{1};
projs.angles = C{2};
projs.detectorXOffsets = C{3};
projs.detectorYOffsets = C{4};
projs.I0 = C{5};

I = imread(fullfile(path,projs.filenames{1}));

[projs.height, projs.width] = size(I);
projs.num = size(projs.filenames, 1);

try
    projs.P = zeros(projs.height,projs.width,projs.num);
catch
    error('Out of Memory!');
end

for i=1:projs.num
   I = imread(fullfile(path, projs.filenames{i}));
   projs.P(:,:,i) = I;
end

for i=1:projs.num
   projs.P(:,:,i) = log(projs.I0(i)) - log(projs.P(:,:,i));
end

%%%%%% ASTRA projs
% 
% vol_geom = astra_create_vol_geom(128, 128, 128);
% %proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 200, 384, linspace2(0,2*pi,360), 100, 40);
% proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 480, 424, linspace2(0,2*pi,360), 1000, 300);
% 
% % Create a 256x256 phantom image using matlab's built-in phantom() function
% %P = phantom(256);
% 
% cube = zeros(128,128,128);
% %cube(17:112,17:112,17:112) = 1;
% cube(50:90,50:90,10:110) = 10;
% 
% % Create a sinogram using the GPU.
% [sinogram_id, sinogram] = astra_create_sino3d_cuda(cube, proj_geom, vol_geom);
% astra_mex_data3d('delete', sinogram_id);
% 
% projs.angles = (0:1:359);
% projs.P = permute(sinogram, [3 1 2]);
% projs.num = length(projs.angles);
% projs.width = 424;
% projs.height = 480;
%projs.angles


% geometry

sourceOffsetX = 0; % not fully supported yet - futher development of projection matrix is needed
sourceOffsetY = 0; % not fully supported yet - futher development of projection matrix is needed

detectorOffsetX = 0;
detectorOffsetY = 0;


% model matlab

projSpacingX = 1.;
projSpacingY = 1.;

SDD = 1300.;
SID = 1000.;
detectorWidth = 424;
detectorHeight = 480;
%newOriginX = -(detectorWidth - 1) / 2 * projSpacingX;
%newOriginY = -(detectorHeight - 1) / 2 * projSpacingY;
newOriginX = -detectorWidth / 2.;
newOriginY = -detectorHeight / 2.;
magn = SDD / SID;

% model tvel

% projSpacingX = 1.;
% projSpacingY = 1.;
% 
% SDD = 1536.;
% SID = 1000.;
% detectorWidth = 424;
% detectorHeight = 480;
% %newOriginX = -(detectorWidth - 1) / 2 * projSpacingX;
% %newOriginY = -(detectorHeight - 1) / 2 * projSpacingY;
% newOriginX = -detectorWidth / 2.;
% newOriginY = -detectorHeight / 2.;
% magn = SDD / SID;

%bug
SDD = 214.119;
SID = 91.770;
detectorWidth = 1000;
detectorHeight = 666;
%detectorOffsetX = detectorWidth / 2;
%detectorOffsetY = detectorHeight / 2;
 newOriginX = -detectorWidth / 2.;
 newOriginY = -detectorHeight / 2.;
magn = SDD / SID;
projSpacingX = 0.00901 * 4;
projSpacingY = 0.00901 * 4;

% foil
% SDD = 184.;
% SID = 148.063;
% detectorWidth = 2452;
% detectorHeight = 1640;
% magn = SDD / SID;
% projSpacingX = 0.0074 * 2;
% projSpacingY = 0.0074 * 2;
% detectorOffsetX = detectorWidth / 2 + 0.5;
% detectorOffsetY = detectorHeight / 2 + 0.5;

% voxelsize = 0.07 
% originX = -140
% originZ = -140
% originY = 0
% dimensionX = 400
% dimensionY = 1
% dimensionZ = 400

voxelsize = 0.01544;
originX = -999/2*voxelsize;
originZ = originX
originY = 0
dimensionX = 1000
dimensionY = 1
dimensionZ = 1000


%y = y * voxelsize;

% y = [5]
% y = y * voxelsize;
% x = [-200:200]
% x = x * voxelsize;
% z = [-200:200]
% z = z * voxelsize;

% parker short scan weighting

% disp('start parker short scan weighting filter');
% 
% 
% torad = pi / 180.;
% tograd = 180. / pi;
% 
% firstAngle = 0. * torad;
% lastAngle = 199.35 * torad;
% 
% if (lastAngle < firstAngle)
%     lastAngle = lastAngle + 2 * pi;
% end
% 
% gap = firstAngle + 2 * pi - lastAngle;
% 
% if (gap < pi / 9)
%     disp('no parker needed');
%     %return;
% end
% 
% weights = [1:detectorWidth];
% 
% delta = 0.5 * (lastAngle - firstAngle - pi);
% delta = delta - 2*pi*floor( delta / (2*pi) )
% 
% corner1 = -detectorOffsetX * projSpacingX;
% corner2 = (detectorOffsetX - 1) * projSpacingX;
% 
% for k=1:projs.num
%     
%     sox = sourceOffsetX;
%     sid = SID;
%     sdd = SDD;
%     invsid = 1. / sqrt(sid * sid + sox * sox);
%     
%     halfDetectorWidth1 = ToUntiltedCoordinateAtIsocenter(corner1, sid, sdd, sox, 0);
%     halfDetectorWidth2 = ToUntiltedCoordinateAtIsocenter(corner2, sid, sdd, sox, 0);
%     halfDetectorWidth = min(halfDetectorWidth1, halfDetectorWidth2);
%     
%     if (delta < atan(halfDetectorWidth * invsid))
%         disp('You do not have enough data for proper Parker weighting (short scan).');
%     end
%         
%     point = -detectorOffsetX * projSpacingX;
%     
%     beta = projs.angles(k) * pi / 180;
%     for i=1:detectorWidth
%         l = ToUntiltedCoordinateAtIsocenter(point, sid, sdd, sox, 0);
%         alpha = atan( -1 * l * invsid );
%         if (beta <= 2 * delta - 2 * alpha)
%             weights(i) = 2. * power(sin( (pi*beta) / (4*(delta-alpha) ) ), 2.);
%         elseif (beta <= pi - 2 * alpha)
%             weights(i) = 2. ;
%         elseif (beta <= pi + 2 * delta)
%             weights(i) = 2. * power(sin( (pi*(pi+2*delta-beta) ) / (4*(delta+alpha) ) ), 2.);
%         end
%         
%         point = point + projSpacingX;
%     end
%     
%     for j=1:detectorHeight
%         for i=1:detectorWidth
%             projs.P(j,i,k) = weights(i) * projs.P(j,i,k);
%         end
%     end
%     
%     if (mod(k, 100) == 0) disp(k); end
%           
% end


% // Prepare weights for current slice (depends on ProjectionOffsetsX)
%     typename WeightImageType::PointType point;
%     weights->TransformIndexToPhysicalPoint(itWeights.GetIndex(), point);
% 
%     // Parker's article assumes that the scan starts at 0, convert projection
%     // angle accordingly
%     double beta = rotationAngles[ itIn.GetIndex()[2] ];
%     beta = beta - firstAngle;
%     if (beta<0)
%       beta += 2*vnl_math::pi;
% 
%     itWeights.GoToBegin();
%     while(!itWeights.IsAtEnd() )
%       {
%       const double l = m_Geometry->ToUntiltedCoordinateAtIsocenter(itIn.GetIndex()[2], point[0]);
%       double alpha = atan( -1 * l * invsid );
%       if(beta <= 2*delta-2*alpha)
%         itWeights.Set( 2. * pow(sin( (itk::Math::pi*beta) / (4*(delta-alpha) ) ), 2.) );
%       else if(beta <= itk::Math::pi-2*alpha)
%         itWeights.Set( 2. );
%       else if(beta <= itk::Math::pi+2*delta)
%         itWeights.Set( 2. * pow(sin( (itk::Math::pi*(itk::Math::pi+2*delta-beta) ) / (4*(delta+alpha) ) ), 2.) );
%       else
%         itWeights.Set( 0. );
% 
%       ++itWeights;
%       point[0] += spacing[0];
%       }    




% weighting

disp('start weighting');

u = (-detectorOffsetX + [0:detectorWidth-1]') * projSpacingX;
v = (-detectorOffsetY + [0:detectorHeight-1]') * projSpacingY;
[uu, vv] = meshgrid(u, v);
W = SDD ./ sqrt(SDD ^ 2 + uu .^ 2 + vv .^ 2);
for k=1:projs.num
    P = projs.P(:,:,k);
    P = P .* W;
    projs.P(:,:,k) = P;
    
    if (mod(k, 100) == 0) disp(k); end
    
end


% ramp filter

disp('start ramp');

filterFunc = 'ram-lak'; % 'ram-lak', 'shepp-logan', 'cosine', 'hamming', 'hann'
d = 1

len = 2 ^ nextpow2(projs.width * 2);
filter = (0 : len / 2) / (len / 2) ;
w = filter * pi;

switch filterFunc
    case 'ram-lak'
        % do nothing
    case 'shepp-logan'
        filter(2:end) = filter(2:end) .* sin(w(2:end) / (2 * d)) / (w(2:end) / (2 * d));
    case 'cosine'
        filter(2:end) = filter(2:end) .* cos(w(2:end) / (2 * d));
    case 'hamming'
        filter(2:end) = filter(2:end) .* (.54 + 0.43 * cos(w(2:end) / d));
    case 'hann'
        filter(2:end) = filter(2:end) .* (1 + cos(w(2:end) / d)) / 2;
end

filter(w > pi * d) = 0;
filter = [filter, filter(end-1:-1:2) ];

for k=1:projs.num
	P = projs.P(:,:,k);
    
    P = fft(P, length(filter), 2);
    
    for row=1:projs.height
        P(row,:) = P(row,:) .* filter;
    end
    
    P = real(ifft(P, [], 2));
    P = P(:,1:projs.width);
    
    projs.P(:,:,k) = P;
    
    if (mod(k, 100) == 0) disp(k); end
end    

   
% backprojection

disp('start backprojection');

%voxelsize = 0.0074 * 2 %/ magn

% y = [5]
% y = y * voxelsize;
% x = [-200:200]
% x = x * voxelsize;
% z = [-200:200]
% z = z * voxelsize;

x = [0:dimensionX - 1] * voxelsize + originX;
y = [0:dimensionY - 1] * voxelsize + originY;
z = [0:dimensionZ - 1] * voxelsize + originZ;


nx = length(x)
ny = length(y)
nz = length(z)

Res = zeros(ny,nx,nz);


for i=1:projs.num


%for k=1:projs.num

    
%    projs.P(:,:,k) = P;
%end        
    

    dR = zeros(ny,nx,nz);

    %angle = i * 2 * pi / 180;
    angle = projs.angles(i) * pi / 180;
    
 %[yy, xx, zz] = ndgrid( y, x, z);
% Use projection matrix to project reconstruction (x,y,z) grid
% into detector (u,v) grid



SuperMatrix = [  SDD/projSpacingX 0 -newOriginX/projSpacingX -newOriginX * SID/projSpacingX
                  0  0         1                  SID          
                  0  SDD/projSpacingY -newOriginY/projSpacingY -newOriginY * SID/projSpacingY ];
    
    
RotationMatrix =       [ cos(angle)      0  sin(angle)    0
                            0            1     0          0 
                         -sin(angle)     0  cos(angle)    0
                            0            0     0          1  ];

[yy, xx, zz] = ndgrid( y, x, z);


OffsetMatrix = [ 1 0 0 detectorOffsetX
                 0 1 0 detectorOffsetY
                 0 0 1 0
                 0 0 0 1 ];


Voxels = [xx(:)'; yy(:)'; zz(:)'; ones(1,nx*ny*nz)];
%Voxels = [xx(:)'; yy(:)'; zz(:)';];
%UV = A * [ xx(:)'; yy(:)'; zz(:)'; ones(1,nx*ny*nz) ];
%UV = A * Voxels; 


Point = [10
     10
     10];
 

 
 
%A = OffsetMatrix * RotationMatrix;
A =  SuperMatrix * RotationMatrix;
A(:,:) = A(:,:)./SID;


R = A * Voxels;

XPerspX = round( R(1,:)./R(2,:) ) + 1 ;
YPerspY = round( R(3,:)./R(2,:) ) + 1 ;


logP=projs.P(:,:,i);

ind = find( XPerspX >= 1 & XPerspX <= detectorWidth & YPerspY >= 1 & YPerspY <= detectorHeight );
    
P_ind = (XPerspX(ind) - 1) * detectorHeight + YPerspY(ind);

W = 1;
%dR( ind ) = W .* logP( P_ind );
dR( ind ) = W .* logP( P_ind );


%dR(ind) = logP(P_ind);

Res = Res + dR;

%disp(Res)

%Cmin=min(min(min(dR)));
%Cmax=max(max(max(dR)));

disp(i)

%P_ind = ( U(ind) - 1 )*nv + V(ind) ;


%ind = find(UV(3) > 0)

%disp(UV(3))


  
%disp()

%disp(V)

end




%axes(handles.axes3);


disp(Res);

%cla;

%imagesc(proj_param.x,proj_param.z,flipud(reshape(R(round(proj_param.y_size/2),:,:),proj_param.x_size,proj_param.z_size))');

Gy = reshape(Res(1,:,:),length(x),length(z))
imagesc(x,z,Gy)
%imagesc(x,z,Res(1,:,:))
xlabel('x [cm]','Color',[0 0 1])
ylabel('y [cm]','Color',[0 0 1])
title('x vs. y [cm]');
axis xy;
axis equal;
axis tight;
colormap bone;
set(gca,'XColor',[0 0 1],'YColor',[0 0 1])
hold on;
%imagesc(x,z,Res(1,:,:))

imagesc(x,z,Gy)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%caxis([Cmin Cmax]);


return





disp(projs.width)
disp(projs.height)
disp(projs.num)




