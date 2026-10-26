% DONT USE IT, IT IS ABSOLUTELY GARBAGE

function [tg, ag] = findMax(g)
    N = size(g);
    for t = 2:N(1, 1)
        if g(t, 2) - g(t-1, 2) < 0
            tg = t; % not an actual time, only sample number
            ag = g(t-1, 2);
            return
        end
    end
end

% g - (:, 2) matrix 
% first column: time, second: value