clc; clear; close all;

load("IdentWsadowaStat.mat");

function output = phi(u)
output = [u.^0, u.^-1, u.^-2, u.^-3];
end

u = DaneStatW(:, 1);
yW = DaneStatW(:, 2);
yC = DaneStatC(:, 2);

Phi = phi(u);

pN_LS_W = ((Phi'*Phi)^-1)*Phi'*yW;
pN_LS_C = ((Phi'*Phi)^-1)*Phi'*yC;

ymW = [u.^0, u.^-1, u.^-2, u.^-3]*pN_LS_W;
ymC = [u.^0, u.^-1, u.^-2, u.^-3]*pN_LS_C;

figure('Name', 'Identification e')
plot(u, yW, '-', u, ymW, '-');
grid on;
xlabel('u');
ylabel('y');
legend('yW', 'ymW');

figure('Name', 'Identification v')
plot(u, yC, '-', u, ymC, '-');
grid on;
xlabel('u');
ylabel('y');
legend('yC', 'ymC');

epsilon = yW - Phi*pN_LS_W;
N = size(yW); N = N(1, 1);
dp = size(pN_LS_W); dp = dp(1 ,1);
sigma2 = (1/(N-dp))*sum(epsilon.^2);
Cov_pN_LS_W = sigma2*(Phi'*Phi)^-1;