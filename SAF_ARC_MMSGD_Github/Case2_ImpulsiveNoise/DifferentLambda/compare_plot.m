clc; clear; close all;
load lam1.mat
load lam2.mat
load lam3.mat
load lam4.mat
load lam5.mat
figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(emf_lam1, '-^', 'linewidth', 2);
f2 = plot(emf_lam2, '-v', 'linewidth', 2);
f3 = plot(emf_lam3, '-s', 'linewidth', 2);
f4 = plot(emf_lam4, '-d', 'linewidth', 2);
f5 = plot(emf_lam5, '-o', 'linewidth', 2);
nummarkers([f1, f2, f3, f4, f5], 8);
% plot(-30*ones(size(emf_saflms)), '--', 'linewidth', 2);
xlabel('Samples'); ylabel('MSE [dB]'); %title('\bfMean Square Error');
set(gca, 'XTick', [0, 6000, 12000, 18000, 24000, 30000]);
set(gca, 'XTicklabel', [0, 6000, 12000, 18000, 24000, 30000]);
h1 = legend(' \lambda = 0.2', ' \lambda = 0.5', ' \lambda = 1.0', ' \lambda = 2.0', ' \lambda = 5.0');
set(h1, 'fontsize', 13, 'location', 'northeast', 'box', 'on');

axes('position', [0.18, 0.7, 0.3, 0.2]);
hold on; grid on; box on;
f1 = plot(emf_lam1(1:200), '-^', 'linewidth', 2);
f2 = plot(emf_lam2(1:200), '-v', 'linewidth', 2);
f3 = plot(emf_lam3(1:200), '-s', 'linewidth', 2);
f4 = plot(emf_lam4(1:200), '-d', 'linewidth', 2);
f5 = plot(emf_lam5(1:200), '-o', 'linewidth', 2);
nummarkers([f1, f2, f3, f4, f5], 3);
set(gca, 'fontweight', 'bold', 'FontSize', 10);

axes('position', [0.46, 0.4, 0.4, 0.2]);
ind = length(emf_lam1)-400:length(emf_lam1);
hold on; grid on; box on;
f1 = plot(3e4, -27);
f2 = plot(ind, emf_lam2(ind), '-v', 'linewidth', 2, 'markersize', 7);
f3 = plot(ind, emf_lam3(ind), '-s', 'linewidth', 2, 'markersize', 7);
f4 = plot(ind, emf_lam4(ind), '-d', 'linewidth', 2, 'markersize', 7);
f5 = plot(3e4, -29);
nummarkers([f1, f2, f3, f4, f5], 5);
set(gca, 'XTicklabel', [29600, 29700, 29800, 29900, 30000]);
set(gca, 'fontweight', 'bold', 'FontSize', 10);