
% 
% dds = zeros(256, 1);
% 
% for (i = 400:409)
%     
%     ds = dataset('File', sprintf('/home/fna/share/ffc/raw%03d_Event.txt', i));
%     %dd = double(ds);
%     %x = dd(:,1);
%     %y = dd(:,2); 
% 
%     cellArray = cellstr(ds);
%     str = char(cellArray(100));
% 
%     C = char(strsplit(str,' '));
% 
%     dd = zeros(256, 1);
%     for i = 1:256
%         dd(i) = str2double(C(i, :));
%     end
%     
%     
%     dds = dds + dd;
% end    
% dds = dds ./ 10; 
% 
% ds = dataset('File', sprintf('/home/fna/share/ffc/raw1_Event.txt', i));
% %dd = double(ds);
% %x = dd(:,1);
% %y = dd(:,2); 
% 
% cellArray = cellstr(ds);
% str = char(cellArray(100));
% 
% C = char(strsplit(str,' '));
% 
% dd = zeros(256, 1);
% for i = 1:256
%     dd(i) = str2double(C(i, :));
% end
% 
% x = 1:256;
% y = dd;
% 
% dd = dd ./ dds * 500;

ds = dataset('File', '/home/fna/share/ffc/pixet_ffc1.txt');
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
    
plot(10:250, dd(10:250), '.-b');

std(dd)

return;