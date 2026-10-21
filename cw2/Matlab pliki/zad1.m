clc; clear;

load("ProcessStepResponse.mat");

figure("Name", "OG system step response")
plot(S(:, 1), S(:, 2))
grid on;
hold on;

[T50, T90] = findT(S);
p_val = T90/T50; % z tabeli wychodzi p = 3
p = 3;
T = calcT(T50, T90, 2.67, 5.32);
K = S(end, 2);

s = tf('s');
G = K/(T*s+1)^p;

[y, tOut] = step(G, S(end, 1));
figure("Name", "Multi-inertion system step response")
plot(tOut, y);
grid on;
hold on;