function [img] = loadTXTMatrix(filename, cols, rows)

img = zeros(rows, cols);

ds = dataset('File', filename);
cellArray = cellstr(ds);
for y = 1:rows
    str = char(cellArray(y));

    C = char(strsplit(str, ' '));

    dd = zeros(cols, 1);
    for i = 1:cols
        dd(i) = str2double(C(i, :));
    end

    img(y, :) = dd';
end