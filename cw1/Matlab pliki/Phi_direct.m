function P = Phi_direct(x, Tp)
    N = size(x);
    N = N(1, 2);
    X = fft(x)*Tp;
    P = 1/(N*Tp)*(abs(X).^2);
end