function [T50, T90] = findT(S)
N = size(S);
A_inf = S(end, 2);
diff = 10^(-3);
for t = 1:N(1, 1)
    if abs(S(t, 2) - 0.5*A_inf) < diff
        T50 = S(t, 1);
    end
    if abs(S(t, 2) - 0.9*A_inf) < diff
        T90 = S(t, 1);
    end
end
end