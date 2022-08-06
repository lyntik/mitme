function [r] = nextcolor()
    global colors;
    global colorIndex;
    curr = colorIndex;
    
    next = curr + 1;
    if (next == 8)
        next = 1;
    end
    
    r = char(colors(next));
    colorIndex = next;
