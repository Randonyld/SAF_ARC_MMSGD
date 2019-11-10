clc; clear; close all;
load safarcmmsgd.mat
load safarc.mat
figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
plot([emf_safarc, emf_safarcmmsgd], 'linewidth', 2);
% plot(-30*ones(size(emf_saflms)), '--', 'linewidth', 2);
xlabel('Samples'); ylabel('MSE [dB]'); %title('\bfMean Square Error');

% a1 = annotation('textarrow', [0.32, 0.4], [0.09, 0.22], 'String', 'Proposed method');
% set(a1, 'fontsize', 15, 'color', 'r');

h1 = legend(' SAF-ARC', ' SAF-ARC-MMSGD');
set(h1, 'fontsize', 12, 'location', 'northeast', 'box', 'on');

axes('position', [0.22, 0.6, 0.3, 0.3]);
plot([emf_safarc(1:200), emf_safarcmmsgd(1:200)], 'linewidth', 2);

axes('position', [0.48, 0.3, 0.4, 0.2]);
ind = length(emf_safarc)-400:length(emf_safarc);
plot(ind, emf_safarc(ind), ind, emf_safarcmmsgd(ind), 'linewidth', 2);