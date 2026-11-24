clc; clear; close all;

load("IdentWsadowaDyn.mat");

N = 4001;
Tp = 0.01;
t = 0:Tp:(N-1)*Tp;

Go = tf(2, [0.5, 1]);

u = DaneDynW(:, 1);
yC = DaneDynC(:, 2);

N_est = floor(N/2);
t_est = t(1:N_est);
t_wer = t(N_est+1:end);

ZestC = [u(1:N_est), yC(1:N_est)];
ZwerC = [u(N_est+1:end), yC(N_est+1:end)];

y0 = lsim(Go, u, t, 'zoh');
y_wer = y0(N_est+1:end);

function output = phi(u, y)
output = [y(1:end-1), u(1:end-1)];
end

PhiC_est = phi(ZestC(:, 1), ZestC(:, 2));
pN_D_C = pinv(PhiC_est)*ZestC(2:end, 2);
PhiC_wer = phi(ZwerC(:, 1), ZwerC(:, 2));
y_predC = PhiC_wer*pN_D_C;
% zestawiam z sygnalem yW zaczynajac od 2. probki zeby zasymulowac przesu-
% niecie o probke. Nie mozna zapisac normalnego rownania, bo wtedy
% y(1) = p1y(0) + p2u(0), a w matlabie nie da się indeksowac od 0 (bruh);
% y(n) = p1y(n-1) + p2u(n-1) => y(n+1) = p1y(n) + p2u(n)

T = -Tp/log(pN_D_C(1));
k = pN_D_C(2)/(1-pN_D_C(1));

Gm_d = tf(pN_D_C(2), [1, -pN_D_C(1)], Tp);
y1 = lsim(Gm_d, u, t);
y1_est = y1(1:N_est);
y1_wer = y1(N_est+1:end);

figure('Name', 'mega figure');
plot(t_wer, ZwerC(:, 2));
hold on;
grid on;
plot(t_wer, y_wer);
plot(t_wer(2:end), y_predC);
plot(t_wer, y1_wer);
legend('zmierzone', 'system czasu ciągłego', ...
    'predyktor', 'model symulowany');

Nv = size(ZwerC, 1);
Vp = (1/Nv)*sum((ZwerC(2:end, 2) - y_predC).^2);
Vm = (1/Nv)*sum((y_wer - y1_wer).^2);

Z = phi(ZestC(:, 1), y1_est);
pN_D_C_IV = (Z'*PhiC_est) \ Z'*ZestC(2:end, 2);
PhiC_wer_IV = phi(ZwerC(:, 1), y1_wer);
y_predC_IV = PhiC_wer_IV*pN_D_C_IV;

T1 = -Tp/log(pN_D_C_IV(1));
k1 = pN_D_C_IV(2)/(1-pN_D_C_IV(1));

Gm_d_IV = tf(pN_D_C_IV(2), [1, -pN_D_C_IV(1)], Tp);
y1_wer_IV = lsim(Gm_d_IV, u, t);
y1_wer_IV_wer = y1_wer_IV(N_est+1:end);

figure('Name', 'mega figure but better')
plot(t_wer, ZwerC(:, 2));
hold on;
grid on;
plot(t_wer, y_wer);
plot(t_wer(2:end), y_predC);
plot(t_wer, y1_wer_IV_wer);
legend('zmierzone', 'system czasu ciągłego', ...
    'predyktor', 'model symulowany');