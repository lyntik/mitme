function [mtf] = calcMtf(filepath, lines)

[raw] = loadMetaImage(filepath);


line = reshape(raw(60, 26, :), [120, 1]);
figure(1);
plot(1:120, line, '.-b');
xlabel('Линий/мм');
ylabel('ПФМ');

i = 0;
min = 0;
max = 0;
mtf = 1000;
iworst = 0;
worst = 1000;
maxworst = 0;
minworst = 0;

f = 1;

prev = line(1);
for x = 2:120
    if (line(x) > 1)
        break;
    end
end


for x = x:120
    if (f == 1)
        if (line(x) < prev)
            max = prev;
            min = line(x);
            f = 0;
        end
    else
        if (line(x) < prev)
            min = line(x);
        else
            i = i + 1;
            
            contrast = max - min;
            if (contrast < worst)
                minworst = min;
                maxworst = max;
                worst = contrast;
                iworst = i;
                if (min < 0) 
                    max = max + abs(min);
                    min = 0;
                end
                mtf = (max - min) / (max + min);
            end
            f = 1;
            
            if (i == lines) 
                break; 
            end            
        end
    end
        
    prev = line(x);
end


