function f = m(data)
    dataSize = size(data);
    N = dataSize(1, 2); %columns
    M = dataSize(1, 1); %rows

    f = zeros(1, M - 1); %first row contains n in nTp

    for i = 2:M
        sum = 0;
        for n = 1:N
            sum = sum + data(i, n);
        end
        f(1, i - 1) = sum/N; %first row contains n in nTp
    end
end