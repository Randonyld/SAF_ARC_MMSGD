clc; clear; close all;
load saflms.mat
load safnlms.mat
load safmcc.mat
load safvsssnlms.mat
load safarcmmsgd.mat
figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(emf_saflms, '-^', 'linewidth', 2);
f2 = plot(emf_safnlms, '-v', 'linewidth', 2);
f3 = plot(emf_safmcc, '-s', 'linewidth', 2);
f4 = plot(emf_safvsssnlms, '-d', 'linewidth', 2);
f5 = plot(emf_safarcmmsgd, '-o', 'linewidth', 2);
nummarkers([f1, f2, f3, f4, f5], 8);
% plot(-30*ones(size(emf_saflms)), '--', 'linewidth', 2);
xlabel('Samples'); ylabel('MSE [dB]'); %title('\bfMean Square Error');
a1 = annotation('textarrow', [0.20, 0.26], [0.07, 0.31], 'String', 'Proposed method');
set(a1, 'fontsize', 15, 'color', 'r');
h1 = legend(' SAF-LMS', ' SAF-NLMS', ' SAF-MCC', ' SAF-VSS-SNLMS', ' SAF-ARC-MMSGD');
set(h1, 'fontsize', 12, 'location', 'northeast', 'box', 'on');

% axes('position', [0.22, 0.6, 0.3, 0.3]);
% plot([emf_saflms(1:200), emf_safnlms(1:200), emf_safmcc(1:200), emf_safvsssnlms(1:200), emf_safarcmmsgd(1:200)], 'linewidth', 2);

axes('position', [0.42, 0.35, 0.45, 0.25]);
ind = length(emf_saflms)-400:length(emf_saflms);
hold on; grid on; box on;
f1 = plot(ind, emf_saflms(ind), '-^', 'linewidth', 2, 'markersize', 6);
f2 = plot(ind, emf_safnlms(ind), '-v', 'linewidth', 2, 'markersize', 6);
f3 = plot(ind, emf_safmcc(ind), '-s', 'linewidth', 2, 'markersize', 6);
f4 = plot(1.2e4, -29.5);
f5 = plot(ind, emf_safarcmmsgd(ind), '-o', 'linewidth', 2, 'markersize', 6);
nummarkers([f1, f2, f3, f4, f5], 5);
set(gca, 'XTicklabel', [11600, 11700, 11800, 11900, 12000]);
set(gca, 'fontweight', 'bold', 'FontSize', 10);
