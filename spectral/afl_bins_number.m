function [number] = afl_bins_number(path, e)

files = dir(sprintf('%s/%d/%d/*.txt', path, e, 0));
number = size(files, 1) - 1;

end