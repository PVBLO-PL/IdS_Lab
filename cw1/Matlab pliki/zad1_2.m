clc; clear;

load('StochasticProcess.mat')

n = StochasticProcess(1, :);
data_size = size(StochasticProcess(2:end,1));
M = 1:data_size(1, 1);
figure;
for i = 1:5
    subplot(3, 2, i);
    plot(n, StochasticProcess(i*10, :));
end

data_mn = mn(StochasticProcess);
data_m = m(StochasticProcess);
data_on = on(StochasticProcess);
data_o = o(StochasticProcess);

figure;
subplot(2,1,1);
plot(n, data_mn,'-x');
hold on;
plot(M,data_m, '-x');

subplot(2,1,2);
plot(n, data_on, '-x');
hold on;
plot(M,data_o, '-x');

avg_data_mn = mean(data_mn);
avg_data_m = mean(data_m);
avg_data_on = mean(data_on);
avg_data_o = mean(data_o);