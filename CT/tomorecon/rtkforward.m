
% geometry
g = py.SimpleRTK.ThreeDCircularProjectionGeometry();
for i=0:359,
    g.AddProjection(500,1000,i);
end

% what projects
cube1 = zeros(128,128,128);
cube = single(cube1);

cube(17:112,17:112,17:112) = 1;
cube(33:96,33:96,33:96) = 0;

data_size = size(cube);
result = py.numpy.reshape(cube(:)', int32(fliplr(size(transpose))));
volume = py.SimpleRTK.GetImageFromArray(result);

const = py.SimpleRTK.ConstantImageSource();
const.SetSpacing(py.list([1,1,1]));
const.SetSize(py.list(int32(data_size)));
const.SetOrigin(py.list([-64.5,-64.5,-64.5]));
volume_meta = const.Execute();

volume.CopyInformation(volume_meta);

% projections
 
const = py.SimpleRTK.ConstantImageSource();
const.SetSpacing(py.list([1,1,1]));
const.SetSize(py.list(int32([512,1,360])));
const.SetOrigin(py.list([-255.5,0,0]));
proj = const.Execute();

% forward

forward = py.SimpleRTK.JosephForwardProjectionImageFilter();
forward.SetGeometry(g);
proj = forward.Execute(proj, img);




