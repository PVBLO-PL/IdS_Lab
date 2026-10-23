clc; clear;

load("ProcessStepResponse.mat");

g = impResp(S);
figure("Name", "OG system step response")
plot(S(:, 1), S(:, 2))
hold on;
plot(g(:, 1), g(:, 2), "r")
grid on;

[T50, T90] = findT(S);
p_val = T90/T50; % z tabeli wychodzi p = 3
p = 3;
T = calcT(T50, T90, 2.67, 5.32);
K = S(end, 2);

s = tf('s');
G1 = K/(T*s+1)^p;

[y, tOut] = step(G1, S(:, 1));
S1 = [tOut, y];
g1 = impResp(S1);
figure("Name", "Multi-inertion system step response")
plot(tOut, y);
hold on;
plot(g1(:, 1), g1(:, 2), "r")
grid on;


[T, T0] = calcT_T0(S, g);
G2 = (K/(T*s+1))*exp(-s*T0);

[y, tOut] = step(G2, S(:, 1));
S2 = [tOut, y];
g2 = impResp(S2);
figure("Name", "Inertion with delay system step response")
plot(tOut, y);
hold on;
plot(g2(:, 1), g2(:, 2), "r")
grid on;
