clc; clear; close all;

load("IdentWsadowaDyn.mat");

% prepare data
Tp = 0.01;
N = size(DaneDynW, 1);
NSplit = floor(N/2);
t = 0:Tp:Tp*(N-1);
tE = t(1:NSplit);
xE = DaneDynW(1:NSplit, 1);
yE = DaneDynW(1:NSplit, 2);

% prepare filters
TF = 50*Tp;
s = tf('s');
F0 = 1/(1+s*TF);
F1 = s/(1+s*TF);

% filter data
yF = lsim(F0, yE, tE, 'foh');
Y = lsim(F1, yE, tE, 'foh'); % ypF
xF = lsim(F0, xE, tE, 'foh');

nStart = 0; % discarding first n samples
Phi = [-yF(nStart+1:end), xF(nStart+1:end)];
p_N_LS = pinv(Phi)*Y(nStart+1:end);
T = 1/p_N_LS(1);
k = p_N_LS(2)*T;

fprintf('k = %.4f\n', k);
fprintf('T = %.4f\n', T);
