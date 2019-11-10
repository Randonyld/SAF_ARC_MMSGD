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
set(gca, 'XTick', [0, 6000, 12000, 18000, 24000, 30000]);
set(gca, 'XTicklabel', [0, 6000, 12000, 18000, 24000, 30000]);
% a1 = annotation('textarrow', [0.3, 0.52], [0.2, 0.36], 'String', 'Proposed method');  % alpha = 1
a1 = annotation('textarrow', [0.16, 0.21], [0.08, 0.28], 'String', 'Proposed method');  % alpha = 1.6
set(a1, 'fontsize', 15, 'color', 'r');
h1 = legend(' SAF-LMS', ' SAF-NLMS', ' SAF-MCC', ' SAF-VSS-SNLMS', ' SAF-ARC-MMSGD');
set(h1, 'fontsize', 12, 'location', 'northeast', 'box', 'on');

axes('position', [0.46, 0.38, 0.4, 0.2]);
ind = length(emf_saflms)-400:length(emf_saflms);
hold on; grid on; box on;
f1 = plot(3e4, -23);
f2 = plot(3e4, -26);
f3 = plot(ind, emf_safmcc(ind), '-s', 'linewidth', 2, 'markersize', 7);
f4 = plot(ind, emf_safvsssnlms(ind), '-d', 'linewidth', 2, 'markersize', 7);
f5 = plot(ind, emf_safarcmmsgd(ind), '-o', 'linewidth', 2, 'markersize', 7);
nummarkers([f1, f2, f3, f4, f5], 5);
set(gca, 'XTicklabel', [29600, 29700, 29800, 29900, 30000]);
set(gca, 'fontweight', 'bold', 'FontSize', 10);