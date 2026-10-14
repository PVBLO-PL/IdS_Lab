clc; clear;

Tp = 0.001;
N = 2000;
n = 0:N-1;
o = 0.8;
H = tf(0.1, [1 -0.9], Tp);

e = o*randn(1, N);
x = sin(2*pi*5*n*Tp);
y = sin(2*pi*5*n*Tp) + e;
v = lsim(H, e, n*Tp)';

figure;
hold on;

subplot(2, 2 , 1);
p1 = plot(n*Tp, e);
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

eT = e';
De = [eT, eT];
e_auto = zeros(1, N);

xT = x';
Dx = [xT, xT];
x_auto = zeros(1, N);

yT = y';
Dy = [yT, yT];
y_auto = zeros(1, N);

vT = v';
Dv = [vT, vT];
v_auto = zeros(1, N);

for tau = n
    e_auto(1, tau+1) = Covar(De, tau, 0);
    x_auto(1, tau+1) = Covar(Dx, tau, 0);
    y_auto(1, tau+1) = Covar(Dy, tau, 0);
    v_auto(1, tau+1) = Covar(Dv, tau, 0);
end

e_auto_flipped = [flip(e_auto(1,2:end)), e_auto];
x_auto_flipped = [flip(x_auto(1,2:end)), x_auto];
y_auto_flipped = [flip(y_auto(1,2:end)), y_auto];
v_auto_flipped = [flip(v_auto(1,2:end)), v_auto];

tau = -(N-1):N-1;

figure;
subplot(2,2,1);
plot(tau,e_auto_flipped);
subplot(2,2,2);
plot(tau,x_auto_flipped);
subplot(2,2,3);
plot(tau,y_auto_flipped);
subplot(2,2,4);
plot(tau,v_auto_flipped);
