N = size(Zdata);
N = N(1, 1);
i = 0:N-1;
Omega1 = ((2*pi/N)*i)';
omega1 = Omega1/Tp;

y = Zdata(:, 2);
x = Zdata(:, 1);

Y = Tp*fft(y);
X = Tp*fft(x);

G1 = Y./X;
Lm1 = 20*log10(abs(G1));
Arg1 = angle(G1)*(180/pi);

figure('Name', 'estymator transmitancji');
subplot(2, 1, 1);
semilogx(omega1, Lm1, 'b');
xlabel('omega');
ylabel('Lm');
axis([10^-2, 10^2, -60, 20]);
grid("on");

subplot(2, 1, 2);
semilogx(omega1, Arg1, 'r');
xlabel('omega');
ylabel('Arg');
axis([10^-2, 10^2, -270, 90]);
grid('on');

%---------------------------------------

Mw = 200;
gamma = Mw;
Gamma = 2*gamma - 1;
k2 = 0:Gamma - 1;
Omega2 = ((2*pi/Gamma)*k2)';
omega2 = Omega2/Tp;
tau = (-gamma:gamma)';

ryu = zeros(length(tau), 1);
ruu = zeros(length(tau), 1);
for t = 1:length(tau)
    ryu(t) = Covar([y, x], tau(t));
    ruu(t) = Covar([x, x], tau(t));
end

Phiyu = zeros(length(Omega2), 1);
Phiuu = zeros(length(Omega2), 1);
w = 0.5 * (1 + cos(tau * pi / Mw)) .* (abs(tau) < Mw);
for i = 1:length(Omega2)
    Phiyu(i) = Tp * sum(ryu .* w .* exp(-1j*Omega2(i)*tau));
    Phiuu(i) = Tp * sum(ruu .* w .* exp(-1j*Omega2(i)*tau));
end

G2 = Phiyu./Phiuu;
Lm2 = 20*log10(abs(G2));
Arg2 = angle(G2)*(180/pi);

figure('Name', 'estymaty widmowych gęstości mocy');
subplot(2, 1, 1);
semilogx(omega2, Lm2, 'b');
xlabel('omega');
ylabel('Lm');
axis([10^-2, 10^2, -60, 20]);
grid("on");

subplot(2, 1, 2);
semilogx(omega2, Arg2, 'r');
xlabel('omega');
ylabel('Arg');
axis([10^-2, 10^2, -270, 90]);
grid('on');

%-----------------------------------

Go = tf(1, [0.1 1.05 0.6 1]);
[MAGG, PHASEG] = bode(Go, omega2);
MAGG = squeeze(MAGG);
LmG = 20*log10(MAGG);
ArgG = squeeze(PHASEG);
figure('Name', 'oryginalna transmitancja')
subplot(2, 1, 1);
semilogx(omega2, LmG, 'b');
xlabel('omega');
ylabel('Lm');
axis([10^-2, 10^2, -60, 20]);
grid on;

subplot(2, 1, 2);
semilogx(omega2, ArgG, 'r');
xlabel('omega');
ylabel('Arg');
axis([10^-2, 10^2, -270, 90]);
grid on;