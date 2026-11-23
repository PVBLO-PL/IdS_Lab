clc; clear; close all;

load("IdentWsadowaDyn.mat");

N = 4001;
Tp = 0.01;
t = 0:Tp:(N-1)*Tp;

Go = tf(2, [0.5, 1]);

u = DaneDynW(:, 1);
yW = DaneDynW(:, 2);
yC = DaneDynC(:, 2);

N_est = floor(N/2);
t_est = t(1:N_est);
t_wer = t(N_est+1:end);

ZestW = [u(1:N_est), yW(1:N_est)];
ZwerW = [u(N_est+1:end), yW(N_est+1:end)];

y0 = lsim(Go, u, t, 'zoh');
y_wer = y0(N_est+1:end);

function output = phi(u, y)
    output = [y(1:end-1), u(1:end-1)];
end

PhiW_est = phi(ZestW(:, 1), ZestW(:, 2));
pN_D_W = pinv(PhiW_est)*ZestW(2:end, 2);
PhiW_wer = phi(ZwerW(:, 1), ZwerW(:, 2));
y_predW = PhiW_wer*pN_D_W;
% zestawiam z sygnalem yW zaczynajac od 2. probki zeby zasymulowac przesu-
% niecie o probke. Nie mozna zapisac normalnego rownania, bo wtedy
% y(1) = p1y(0) + p2u(0), a w matlabie nie da się indeksowac od 0 (bruh);
% y(n) = p1y(n-1) + p2u(n-1) => y(n+1) = p1y(n) + p2u(n)

T = -Tp/log(pN_D_W(1));
k = pN_D_W(2)/(1-pN_D_W(1));

Gm_d = tf(pN_D_W(2), [1, -pN_D_W(1)], Tp);
y1 = lsim(Gm_d, u);
ymW = y1(N_est+1:end);

figure('Name', 'mega figure');
plot(t_wer, ZwerW(:, 2));
hold on;
grid on;
plot(t_wer, y_wer);
plot(t_wer(2:end), y_predW);
plot(t_wer, ymW);
legend('zmierzone', 'system czasu ciągłego', ...
       'predyktor', 'model symulowany');
