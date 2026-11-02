% First run zad2_settings.m, then run AKident.mdl
t = Zdata(:, 3);
y = Zdata(:, 2);
u = Zdata(:, 1);
M = 20;
U = [u, u];
D = [y, u];

% figure('Name', 'Measured data')
% plot(t, u, 'b');
% hold on;
% plot(t, y, 'r');

ogGz = tf([2, 0], [1, -0.7], Tp);
[og_y, og_t] = impulse(ogGz);

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

figure('Name', 'Imp response');
plot(0:M-1, gzM1, 'b');
hold on;
plot(0:M-1, gzM2, 'r');
plot(og_t, og_y, 'g');
grid on;
