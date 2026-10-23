function g = impResp(S)
N = size(S);
g = zeros(N);
g(:, 1) = S(:, 1);
for t = 2:N(1, 1)
    g(t, 2) = (S(t, 2)-S(t-1, 2))/(S(t, 1)-S(t-1, 1));
end

% S - (:, 2) matrix 
% first column: time, second: value