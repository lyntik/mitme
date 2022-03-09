
global colorIndex;
colorIndex = 1;

%%%%%%%%%%%%%%% 1
%%
path = '/home/fna/scans/test3/deg1_2';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

p1 = mean(img(368:381, 2794));
p2 = mean(img(368:381, 2795));
p3 = mean(img(368:381, 2796));

%imagesc(img);
p2_ = zeros(30, 1);

for exp=0:29
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(368:381, 2795));    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:30, p2_, '.-b'); hold on;

%%

path = '/home/fna/scans/test3/deg1_3';

t = Tiff(sprintf('%s/001_0000.tif', path) ,'r');
img = read(t);

p1 = mean(img(105:115, 159));
p2 = mean(img(105:115, 160));
p3 = mean(img(105:115, 161));

%imagesc(img);
p2_ = zeros(9, 1);

for exp=1:9
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp) = mean(img(105:115, 160));
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:9, p2_, '.-b'); hold on;



%%
path = '/home/fna/scans/test3/deg1_4';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 136:146;
x = 2752;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(5, 1);

for exp=0:4
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y, x+1));    
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:5, p2_, '.-b'); hold on;

%%
path = '/home/fna/scans/test3/deg1_5';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 136:146;
x = 2752;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(5, 1);

for exp=0:4
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y, x+1));    
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:5, p2_, '.-b'); hold on;



%% X
path = '/home/fna/scans/test3/deg1_1';
t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 136:146;
x = 2748;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(3, 1);

for exp=0:2
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y, x+1));    
    
end    

plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:3, p2_, '.-b'); hold on;

%% Y
path = '/home/fna/scans/test3/deg1';
t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 56;
x = 1540;
p1 = mean(img(y, x));
p2 = mean(img(y+1, x));
p3 = mean(img(y+2, x));

%imagesc(img);
p2_ = zeros(3, 1);

for exp=0:2
    t = Tiff(sprintf('%s/%03d_0360.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y+1, x));    
    
end    

plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:3, p2_, '.-b'); hold on;


%%%%%%%%%%%%%%% 0.5

%%
path = '/home/fna/scans/test3/deg0.5';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

p1 = mean(img(192:200, 2796));
p2 = mean(img(192:200, 2797));
p3 = mean(img(192:200, 2798));

%imagesc(img);
p2_ = zeros(10, 1);

for exp=0:9
    t = Tiff(sprintf('%s/%03d_0720.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(368:381, 2795));    
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:10, p2_, '.-b'); hold on;


%%
path = '/home/fna/scans/test3/deg0.5_2';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 232:240;
x = 2753;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(5, 1);

for exp=0:4
    t = Tiff(sprintf('%s/%03d_0720.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y, x+1));    
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:5, p2_, '.-b'); hold on;


%%
path = '/home/fna/scans/test3/deg0.5_3';

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 232:240;
x = 2753;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(2, 1);

for exp=0:1
    t = Tiff(sprintf('%s/%03d_0720.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y, x+1));    
    
end    


plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:2, p2_, '.-b'); hold on;



%%%%%%%%%%%%%%% 0.1



%% X
path = '/home/fna/scans/test3/deg0.1';
t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 136:146;
x = 2750;
p1 = mean(img(y, x));
p2 = mean(img(y, x+1));
p3 = mean(img(y, x+2));

%imagesc(img);
p2_ = zeros(5, 1);
p2per_ = zeros(5, 1);

for exp=0:4
    t = Tiff(sprintf('%s/%03d_3600.tif', path, exp) ,'r');
    img = read(t);

    v = mean(img(y, x+1))
    p2_(exp+1) = v;
    
    if ((v - p2) * (p1 - p2)) > 0
        p2per_(exp+1) = (v - p2) / (p1 - p2);
    else
        p2per_(exp+1) = (v - p2) / (p3 - p2);
    end
end    

%plot(1:5, p2per_, '.-b'); hold on;

plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:5, p2_, '.-b'); hold on;


%function plotAxePlay(path, shots, expNumber, x, y, axe, type)



%% Y
path = '/home/fna/scans/test3/deg0.1';
t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

y = 56;
x = 1540;
p1 = mean(img(y, x));
p2 = mean(img(y+1, x));
p3 = mean(img(y+2, x));

figure(2);
%imagesc(img);
p2_ = zeros(3, 1);

for exp=0:2
    t = Tiff(sprintf('%s/%03d_3600.tif', path, exp) ,'r');
    img = read(t);

    p2_(exp+1) = mean(img(y+1, x));    
    
end    

plot(1, p1, 'k*'); hold on;
plot(1, p2, 'b*'); hold on;
plot(1, p3, 'g*'); hold on;
plot(1:3, p2_, '.-b'); hold on;




















