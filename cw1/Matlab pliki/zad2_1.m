clc; clear;

N = 2000;
n = 0:N-1;
Tp = 0.001;
o = 1;
f = 0:1/(N*Tp):1/Tp-1/(N*Tp);

x = sin(2*pi*5*n*Tp) + 0.5*sin(2*pi*10*n*Tp) + 0.25*sin(2*pi*30*n*Tp);
e = o*randn(1, N);
H = tf(0.1, [1 -0.9], Tp);
v = lsim(H, e, n*Tp);

figure('Name', 'Signals');
hold on;
subplot(2, 2, 1);
plot(n, x, '-x');
subplot(2, 2, 2);
plot(n, e, '-x');
subplot(2, 2, 3);
plot(n, v, '-x');

figure('Name', 'XN');
hold on;
XN = fft(x)*Tp;
stem(f, abs(XN)*2/(N*Tp), '-x');

a = Tp*sum(x.^2);
b = sum((abs(XN).^2)*1/(N*Tp));
tol = 0.001;
if (a-b) <= tol
    disp('True')
else
    disp('False')
end

Mw = 40;
K = 0:N-1;

%Phi_14 = 1/(N*Tp) * abs(XN).^2;
Phi_14 = Phi_direct(x, Tp);

function omega = w(tau, Mw)
    if abs(tau) <= Mw 
        omega = 1;
    else 
        omega = 0;
    end
end

xT = x';
Dx = [xT, xT];
%Phi_16 = Phi_16 + Tp*sum(w(tau_arg, Mw)*Covar(Dx, tau_arg, 0)*exp(-1j*Omega_k*tau_arg));
%Phi_16 = zeros(size(K));
%for k = K
%    Omega_k = (2*pi/N)*k;
%    for tau = -Mw:Mw
%        Phi_16(k+1) = Phi_16(k+1) + w(tau, Mw)*...
%            Covar(Dx, tau, 0)*exp(complex(0, -1*Omega_k*tau));
%    end
%    Phi_16(k+1) = Phi_16(k+1)*Tp;
%end

figure('Name', 'Density');
hold on;
subplot(2, 1, 1);
stem(K*(2*pi/N), Phi_direct(x, Tp), '-x');
subplot(2, 1, 2);
stem(K*(2*pi/N), abs(Phi_indirect(x, Mw, @w, Tp)), '-x');