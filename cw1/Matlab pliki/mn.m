function f = mn(data)
    dataSize = size(data);
    N = dataSize(1, 2); %columns
    M = dataSize(1, 1); %rows

    f = zeros(1, N);

    for n = 1:N
        sum = 0;
        for i = 2:M %first row contains n in nTp
            sum = sum + data(i, n);
        end
        f(1, n) = sum/(M-1); %first row contains n in nTp
    end
end