clc; clear; close all;

Tp = 1;
tend = 1000;
sigma2v = 0.001;

sim("AKident.mdl");

t = Zdata(:, 3);
y = Zdata(:, 1);
u = Zdata(:, 2);
M = 20;
U = [u, u];
D = [y, u];

figure('Name', 'Measured data')
subplot(2, 1, 1);
plot(t, u, 'b');
grid on;
subplot(2, 1, 2);
plot(t, y, 'r');
grid on;

r_yu = zeros(M, 1);
R_uu = zeros(M);
for i = 0:M-1
    r_yu(i+1, 1) = Covar(D, i);
    for j = 0:M-1
        R_uu(i+1, j+1) = Covar(U, j-i);
    end
end

gsM1 = (1/Tp)*pinv(R_uu)*r_yu;
gsM2 = (1/Tp)*r_yu/R_uu(1, 1);

hM = zeros(M-1, 1);
for i = 0:M-1
    sum = 0;
    for j = 0:i
        sum = sum + gsM1(j+1, 1);
    end
    hM(i+1, 1) = sum*Tp;
end


figure('Name', 'Step response')
plot((0:M-1)*Tp, hM, 'b');
grid on;