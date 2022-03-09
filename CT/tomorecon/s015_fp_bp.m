% -----------------------------------------------------------------------
% This file is part of the ASTRA Toolbox
% 
% Copyright: 2010-2016, iMinds-Vision Lab, University of Antwerp
%            2014-2016, CWI, Amsterdam
% License: Open Source under GPLv3
% Contact: astra@uantwerpen.be
% Website: http://www.astra-toolbox.com/
% -----------------------------------------------------------------------


% This example demonstrates using the FP and BP primitives with Matlab's lsqr
% solver. Calls to FP (astra_create_sino_cuda) and
% BP (astra_create_backprojection_cuda) are wrapped in a function astra_wrap,
% and a handle to this function is passed to lsqr.

% Because in this case the inputs/outputs of FP and BP have to be vectors
% instead of images (matrices), the calls require reshaping to and from vectors.

function s015_fp_bp
% 
% % FP/BP wrapper function
% function Y = astra_wrap(X,T)
%   if strcmp(T, 'notransp')
%     % X is passed as a vector. Reshape it into an image.
%     [sid, s] = astra_create_sino_cuda(reshape(X,[vol_geom.GridRowCount vol_geom.GridColCount])', proj_geom, vol_geom);
%     astra_mex_data2d('delete', sid);
%     % now s is the sinogram. Reshape it back into a vector
%     Y = reshape(s',[prod(size(s)) 1]);
%   else
%     % X is passed as a vector. Reshape it into a sinogram.
%     v = astra_create_backprojection_cuda(reshape(X, [proj_geom.DetectorCount size(proj_geom.ProjectionAngles,2)])', proj_geom, vol_geom);
%     % now v is the resulting volume. Reshape it back into a vector
%     Y = reshape(v',[prod(size(v)) 1]);
%   end
% end

% a = [1 2 3 4; 3 2 1 4];
% bring = reshape(a, [prod(size(a)) 1]);
% 
% in = reshape(bring, [2 4]);
% in


%return;


% FP/BP wrapper function
function Y = astra_wrap(X,T)
  if strcmp(T, 'notransp')
    % X is passed as a vector. Reshape it into an image.
    [sid, s] = astra_create_sino3d_cuda(reshape(X,[vol_geom2.GridRowCount vol_geom2.GridColCount 128]), proj_geom, vol_geom2);
    astra_mex_data3d('delete', sid);
    % now s is the sinogram. Reshape it back into a vector
    Y = reshape(s,[prod(size(s)) 1]);
  else
    % X is passed as a vector. Reshape it into a sinogram.
    [id, v] = astra_create_backprojection3d_cuda(reshape(X, [proj_geom.DetectorColCount size(proj_geom.ProjectionAngles,2) proj_geom.DetectorRowCount]), proj_geom, vol_geom2);
    % now v is the resulting volume. Reshape it back into a vector
    astra_mex_data3d('delete', id);
    Y = reshape(v,[prod(size(v)) 1]);
  end
end


vol_geom = astra_create_vol_geom(128, 128, 128);
%proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 200, 384, linspace2(0,2*pi,360), 100, 40);
proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 200, 384, linspace2(0,2*pi,360), 1000, 300);

% Create a 256x256 phantom image using matlab's built-in phantom() function
%P = phantom(256);

cube = zeros(128,128,128);
%cube(17:112,17:112,17:112) = 1;
cube(50:90,50:90,10:110) = 10;


% Create a sinogram using the GPU.
[sinogram_id, sinogram] = astra_create_sino3d_cuda(cube, proj_geom, vol_geom);

vol_geom = astra_create_vol_geom(128, 128, 128);
[id, vol] = astra_create_backprojection3d_cuda(sinogram, proj_geom, vol_geom);
astra_mex_data3d('delete', id);

for i=1:128
    %figure(2), imshow(squeeze(rec(:,:,i)),[]);
    figure(2), imshow(vol(:,:,i),[]);
    %title(num2str(i));
    pause(0.01);
end


return;
% 
% vol = astra_create_backprojection_cuda(sinogram, proj_geom, vol_geom);
% 
% figure(2), imshow(vol(:,:),[]);
%  
% return;

vol_geom2 = astra_create_vol_geom(128, 128, 128);

% Reshape the sinogram into a vector
%b = reshape(sinogram',[prod(size(sinogram)) 1]);
b = reshape(sinogram,[prod(size(sinogram)) 1]);

% Call Matlab's lsqr with ASTRA FP and BP
Y = lsqr(@astra_wrap,b,1e-4,25);

% Reshape the result into an image
Y = reshape(Y,[vol_geom.GridRowCount vol_geom.GridColCount 128]);

for i=1:128
    %figure(2), imshow(squeeze(rec(:,:,i)),[]);
    figure(2), imshow(Y(:,:,i),[]);
    %title(num2str(i));
    pause(0.01);
end


%astra_mex_data2d('delete', sinogram_id);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return;

vol_geom = astra_create_vol_geom(128, 128, 128);
%proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 200, 384, linspace2(0,2*pi,360), 100, 40);
proj_geom = astra_create_proj_geom('cone', 1.0, 1.0, 400, 584, linspace2(0,2*pi,360), 1000, 300);

% Create a 256x256 phantom image using matlab's built-in phantom() function
%P = phantom(256);

cube = zeros(128,128,128);
%cube(17:112,17:112,17:112) = 1;
cube(60:70,60:70,10:110) = 10;


% Create a sinogram using the GPU.
[sinogram_id, sinogram] = astra_create_sino3d_cuda(cube, proj_geom, vol_geom);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create a data object for the reconstruction
rec_id = astra_mex_data3d('create', '-vol', vol_geom);

% Set up the parameters for a reconstruction algorithm using the GPU
cfg = astra_struct('SIRT3D_CUDA');
cfg.ReconstructionDataId = rec_id;
cfg.ProjectionDataId = sinogram_id;


% Create the algorithm object from the configuration structure
alg_id = astra_mex_algorithm('create', cfg);

% Run 150 iterations of the algorithm
% Note that this requires about 750MB of GPU memory, and has a runtime
% in the order of 10 seconds.
astra_mex_algorithm('iterate', alg_id, 150);
%astra_mex_algorithm('run', alg_id);

% Get the result
rec = astra_mex_data3d('get', rec_id);
%figure, imshow(squeeze(rec(:,:,65)),[]);

for i=1:128
    %figure(2), imshow(squeeze(rec(:,:,i)),[]);
    figure(2), imshow(rec(:,:,i),[]);
    %title(num2str(i));
    pause(0.01);
end


% Clean up. Note that GPU memory is tied up in the algorithm object,
% and main RAM in the data objects.
astra_mex_algorithm('delete', alg_id);
astra_mex_data3d('delete', rec_id);
astra_mex_data3d('delete', sinogram_id);










end
