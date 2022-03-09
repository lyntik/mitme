ds = dataset('File', '/home/fna/data/desy/frames/CS_beam_04.txt');
%dd = double(ds);
%x = dd(:,1);
%y = dd(:,2); 

cellArray = cellstr(ds);
str = char(cellArray(100));

C = char(strsplit(str,' '));

dd = zeros(256, 1);
for i = 1:256
    dd(i) = str2double(C(i, :));
end


x = 1:256;
y = dd;
    
plot(1:256, dd, '.-b');