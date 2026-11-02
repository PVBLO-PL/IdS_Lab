% First run zad2_settings.m, then run AKident.mdl
t = Zdata(:, 3);
y = Zdata(:, 2);
u = Zdata(:, 1);
M = 30;
U = [u, u];
D = [y, u];

s = tf('s');
ogGs = ((0.5)/(5*s^3+11*s^2+7*s+1))*exp(-3*s);
[og_y, og_t] = step(ogGs);
[y_imp, t_imp] = impulse(ogGs);

% figure('Name', 'Measured data')
% subplot(2, 1, 1);
% plot(t, u, 'b');
% grid on;
% subplot(2, 1, 2);
% plot(t, y, 'r');
% grid on;

r_yu = zeros(M, 1);
R_uu = zeros(M);
for i = 0:M-1
    r_yu(i+1, 1) = Covar(D, i);
    for j = 0:M-1
        R_uu(i+1, j+1) = Covar(U, j-i);
    end
end

gsM1 = (1/Tp)*(pinv(R_uu)*r_yu);
gsM2 = (1/Tp)*(r_yu/R_uu(1, 1));

hM1 = zeros(M, 1);
for i = 0:M-1
    sum = 0;
    for j = 0:i
        sum = sum + gsM1(j+1, 1);
    end
    hM1(i+1, 1) = sum*Tp;
end


figure('Name', 'step response')
plot((0:M-1)*Tp, hM1, 'b');
hold on;
plot(og_t, og_y, 'r');
grid on;

figure('Name', 'imp response')
plot((0:M-1)*Tp, gsM1, 'b');
hold on;
plot(t_imp, y_imp, 'r');
grid on;