clc; clear; close all;

Tp = 1;
tend = 1000;
sigma2v = 0;

sim("AKident.mdl");

t = Zdata(:, 3);
y = Zdata(:, 1);
u = Zdata(:, 2);
M = 20;
U = [u, u];
D = [y, u];

figure('Name', 'Measured data')
plot(t, u, 'b');
hold on;
plot(t, y, 'r');

r_yu = zeros(M-1, 1);
R_uu = zeros(M-1);
for i = 0:M-1
    r_yu(i+1, 1) = Covar(D, i);
    for j = 0:M-1
        R_uu(i+1, j+1) = Covar(U, j-i);
    end
end

gzM1 = pinv(R_uu)*r_yu;
gzM2 = r_yu/R_uu(1, 1);
