clc; clear;

Tp = 0.001;
N = 2000;
n = 0:N-1;
o = 0.8;
H = tf(0.1, [1 -0.9], Tp);

e = o*randn(1, N);
x = sin(2*pi*5*n*Tp);
y = sin(2*pi*5*n*Tp) + e;
v = lsim(H, e, n*Tp);

figure;
hold on;

subplot(2, 2 , 1);
p1 = plot(n*Tp, e, 'w');
xlabel('nTp');
ylabel('e(nTp)');

subplot(2, 2 , 2);
plot(n*Tp, x, 'b');
xlabel('nTp');
ylabel('x(nTp)');

subplot(2, 2 , 3);
plot(n*Tp, y, 'g');
xlabel('nTp');
ylabel('y(nTp)');

subplot(2, 2 , 4);
plot(n*Tp, v, 'r');
xlabel('nTp');
ylabel('v(nTp)');

eT = transpose(e);
De = [eT, eT];
e_auto = zeros(1, N);

xT = transpose(x);
Dx = [xT, xT];
x_auto = zeros(1, N);

yT = transpose(y);
Dy = [yT, yT];
y_auto = zeros(1, N);

vT = transpose(v);
Dv = [vT, vT];
v_auto = zeros(1, N);

for tau = n
    e_auto(1, tau+1) = Covar(De, tau);
    x_auto(1, tau+1) = Covar(Dx, tau);
    y_auto(1, tau+1) = Covar(Dy, tau);
    v_auto(1, tau+1) = Covar(Dv, tau);
end