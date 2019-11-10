clc; clear; close all;
load a1.mat
load a2.mat
figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(msgd1, '--', 'linewidth', 2);
f2 = plot(msgd2, '-', 'linewidth', 2);
plot(-30*ones(size(msgd1)), 'k-.', 'linewidth', 2);
ylim([-31, 0]);
title('\bfSystem identification test'); xlabel('Samples'); ylabel('MSE [dB]');

h1 = legend(' {\ita} = 0.1', ' {\ita} = 0.9', ' NoiseLevel');
set(h1, 'fontsize', 13, 'location', 'northeast', 'box', 'on');

axes('position', [0.38, 0.4, 0.48, 0.3]);
ind = length(msgd1)-400:length(msgd1);
hold on; box on; grid on;
f3 = plot(ind, msgd1(ind), '--', 'linewidth', 2);
f4 = plot(ind, msgd2(ind), '-', 'linewidth', 2);
nummarkers([f3, f4], 10);
set(gca, 'XTicklabel', [11600, 11700, 11800, 11900, 12000]);
set(gca, 'fontweight', 'bold', 'FontSize', 10);