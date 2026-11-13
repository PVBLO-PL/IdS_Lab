N = size(Zdata);
N = N(1, 1);
k = 0:N-1;
Omega = ((2*pi/N)*k)';
omega = Omega/Tp;

y = Zdata(:, 2);
x = Zdata(:, 1);

Y = Tp*fft(y);
X = Tp*fft(x);

G1 = Y./X;
Lm1 = 20*log(abs(G1));
Arg1 = angle(G1)*(180/pi);

figure('Name', 'estymator transmitancji');
subplot(2, 1, 1);
semilogx(omega, Lm1, 'b');
xlabel('omega');
ylabel('Lm');
grid("on");

subplot(2, 1, 2);
semilogx(omega, Arg1, 'r');
xlabel('omega');
ylabel('Arg');
grid('on');

%---------------------------------------

Mw = 200;
gamma = N-1;
tau = (-gamma:gamma)';
ryu = zeros(length(tau), 1);
ruu = zeros(length(tau), 1);

for t = 1:length(tau)
    ryu(t) = Covar([y, x], tau(t));
    ruu(t) = Covar([x, x], tau(t));
end
Phiyu = zeros(length(Omega), 1);
Phiuu = zeros(length(Omega), 1);
w = 0.5 * (1 + cos(tau * pi / Mw)) .* (abs(tau) < Mw);
for k = 1:length(Omega)
    Phiyu(k) = Tp * sum(ryu .* w .* exp(-1j*Omega(k)*tau));
    Phiuu(k) = Tp * sum(ruu .* w .* exp(-1j*Omega(k)*tau));
end

G2 = Phiyu./Phiuu;
Lm2 = 20*log(abs(G2));
Arg2 = angle(G2)*(180/pi);

figure('Name', 'estymaty widmowych gęstości mocy');
subplot(2, 1, 1);
semilogx(omega, Lm2, 'b');
xlabel('omega');
ylabel('Lm');
grid("on");

subplot(2, 1, 2);
semilogx(omega, Arg2, 'r');
xlabel('omega');
ylabel('Arg');
grid('on');

%-----------------------------------

Go = tf(1, [0.1 1.05 0.6 1]);
figure('Name', 'oryginalna transmitancja')
bode(Go);
grid on;