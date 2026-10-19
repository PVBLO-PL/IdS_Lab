function P = Phi_indirect(x, Mw, window, Tp)
    N = size(x);
    N = N(1, 2);
    K = 0:N-1;
    xT = x';
    Dx = [xT, xT];
    P = zeros(size(K));
    for k = K
        Omega_k = (2*pi/N)*k;
        for tau = -Mw:Mw
            P(k+1) = P(k+1) + window(tau, Mw)*...
                Covar(Dx, tau, 0)*exp(complex(0, -1*Omega_k*tau));
        end
        P(k+1) = P(k+1)*Tp;
    end
end