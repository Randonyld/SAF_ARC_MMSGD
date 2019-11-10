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
set(gca, 'XTick', [0, 10000, 20000, 30000, 40000, 50000]);
set(gca, 'XTicklabel', [0, 10000, 20000, 30000, 40000, 50000]);
% a1 = annotation('textarrow', [0.3, 0.52], [0.2, 0.36], 'String', 'Proposed method');  % alpha = 1
a1 = annotation('textarrow', [0.23, 0.28], [0.08, 0.21], 'String', 'Proposed method');  % alpha = 1.6
set(a1, 'fontsize', 15, 'color', 'r');
h1 = legend(' SAF-LMS', ' SAF-NLMS', ' SAF-MCC', ' SAF-VSS-SNLMS', ' SAF-ARC-MMSGD');
set(h1, 'fontsize', 12, 'location', 'northeast', 'box', 'on');

% axes('position', [0.5, 0.38, 0.4, 0.2]);
% ind = length(emf_saflms)-400:length(emf_saflms);
% hold on; grid on; box on;
% f1 = plot(5e4, -26);
% f2 = plot(5e4, -29);
% f3 = plot(ind, emf_safmcc(ind), '-s', 'linewidth', 2, 'markersize', 7);
% f4 = plot(ind, emf_safvsssnlms(ind), '-d', 'linewidth', 2, 'markersize', 7);
% f5 = plot(ind, emf_safarcmmsgd(ind), '-o', 'linewidth', 2, 'markersize', 7);
% nummarkers([f1, f2, f3, f4, f5], 5);
% set(gca, 'XTicklabel', [49600, 49700, 49800, 49900, 50000]);
% set(gca, 'fontweight', 'bold', 'FontSize', 10);