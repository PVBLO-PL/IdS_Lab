function [T50, T90] = findT(S)
N = size(S);
A_inf = S(end, 2);
diff_min50 = 100;
diff_min90 = 100;
for t = 1:N(1, 1)
    if abs(S(t, 2) - 0.5*A_inf) < diff_min50
        T50 = S(t, 1);
        diff_min50 = abs(S(t, 2) - 0.5*A_inf);
    end
    if abs(S(t, 2) - 0.9*A_inf) < diff_min90
        T90 = S(t, 1);
        diff_min90 = abs(S(t, 2) - 0.9*A_inf);
    end
end
end

% S - (:, 2) matrix 
% first column: time, second: value