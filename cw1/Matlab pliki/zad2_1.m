clc; clear;

N = 2000;
n = 0:N-1;
Tp = 0.001;
o = 1;

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
plot(n, abs(XN), '-x');

figure('Name', 'Ns');
hold on;

for N_f = [1000, 200, 100]
    n_f = 0:N_f-1;
    x_f = sin(2*pi*5*n_f*Tp) + 0.5*sin(2*pi*10*n_f*Tp) + 0.25*sin(2*pi*30*n_f*Tp);
    XN_f = fft(x_f)*Tp;
    subplot(3, 1, find([1000, 200, 100] == N_f));
    plot(n_f, abs(XN_f), '-x');
end

a = Tp*sum(x.^2);
b = sum((abs(XN).^2)*1/(N*Tp));
tol = 0.001;
if (a-b) <= tol
    disp('True')
else
    disp('False')
end

Mw = 5;
k = 0:N-1;
Omega_k = 2*(pi/N)*k;
tau = -Mw:Mw;

Phi_14 = 1/(N*Tp) * abs(XN).^2;

function omega = w(tau, Mw)
    if abs(tau) <= Mw 
        omega = 1;
    else 
        omega = 0;
    end
end

xT = x';
Dx = [xT, xT];

Phi_16 = zeros(size(Omega_k));
for tau_arg = tau
Phi_16 = Phi_16 + Tp*sum(w(tau_arg, Mw)*Covar(Dx, tau_arg, 0)*exp(-1j*Omega_k*tau_arg));
end
Phi_16 = Phi_16*Tp;



figure('Name', 'Density');
hold on;

subplot(2, 1, 1);
plot(Omega_k, Phi_14, '-x');

subplot(2, 1, 2);
plot(Omega_k, abs(Phi_16), '-x');