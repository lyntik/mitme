

t = Tiff('/data/shared/OLD_SCANS/skyscan/results/acc11m7/ac11m7_0332.tif', 'r');
imagesc(read(t));
return;

path = '/m2/scans/ximea/disc/250mka_9shots';

for f=0:359
    imgsum = zeros(232, 5056, 'uint16');
    for i=0:3
        t = Tiff(sprintf('%s/%d/img_%04d.tif', path, i, f), 'r');
        img = uint16(read(t));
        imgsum = uint16(img) + imgsum;
    end
    
    imgsum =  imgsum ./ 4;
    
    t = Tiff(sprintf('%s/sum/img_%04d.tif', path, f), 'w');
    tagstruct.ImageLength = size(imgsum,1); 
    tagstruct.ImageWidth = size(imgsum,2);
    tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
    tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
    tagstruct.BitsPerSample = 16;
    tagstruct.SamplesPerPixel = 1;
    tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky; 
    tagstruct.Software = 'MATLAB'; 
    setTag(t,tagstruct);
    write(t,imgsum);
    close(t);    
    

end