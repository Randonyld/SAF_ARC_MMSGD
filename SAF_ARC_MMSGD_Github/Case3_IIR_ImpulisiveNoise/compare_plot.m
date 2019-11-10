clc; clear; close all;
load saflms.mat
load safnlms.mat
load safmcc.mat
load safarcmmsgd.mat
load safvsssnlms.mat

mmsgd = emf_safarcmmsgd;
mcc = emf_safmcc;
lambda = 0.998;
for n = 2:length(emf_saflms)
    emf_safarcmmsgd(n) = lambda*emf_safarcmmsgd(n-1) + (1-lambda)*mmsgd(n);
    emf_safmcc(n) = lambda*emf_safmcc(n-1) + (1-lambda)*mcc(n);
end

figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(emf_saflms, '-^', 'linewidth', 2);
f2 = plot(emf_safnlms, '-v', 'linewidth', 2);
f3 = plot(emf_safmcc, '-s', 'linewidth', 2);
f4 = plot(emf_safvsssnlms, '-d', 'linewidth', 2);
f5 = plot(emf_safarcmmsgd, '-o', 'linewidth', 2);
nummarkers([f1, f2, f3, f4, f5], 8);

% plot(-30*ones(size(emf_saflms)), '--', 'linewidth', 2);
xlabel('Samples'); ylabel('MSE [dB]'); %ylim([-30, 30]);

set(gca, 'XTick', [0, 20000, 40000, 60000, 80000]);
set(gca, 'XTicklabel', [0, 20000, 40000, 60000, 80000]);

h1 = legend(' SAF-LMS', ' SAF-NLMS', ' SAF-MCC', ' SAF-VSS-SNLMS', ' SAF-ARC-MMSGD');
set(h1, 'fontsize', 13, 'location', 'northeast', 'box', 'on');

a1 = annotation('textarrow', [0.22, 0.25], [0.08, 0.22], 'String', 'Proposed method');
set(a1, 'fontsize', 15, 'color', 'r');