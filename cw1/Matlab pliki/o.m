function f = o(data)
    dataSize = size(data);
    N = dataSize(1, 2); %columns
    M = dataSize(1, 1); %rows
    data_m = m(data);

    f = zeros(1, M - 1);

    for i = 2:M %first row contains n in nTp
        sum = 0;
        for n = 1:N
            sum = sum + (data(i, n) - data_m(1, i - 1))^2;
        end
        f(1, i - 1) = sum/N; %first row contains n in nTp
    end
end