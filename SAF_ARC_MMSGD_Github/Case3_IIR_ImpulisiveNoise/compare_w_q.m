clc; clear; close all;
load mcc.mat
load msgd.mat
Co = linspecer(3);
figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(wmcc, '-o', 'linewidth', 2, 'markersize', 8);
f2 = plot(wmsgd, '-s', 'linewidth', 2, 'markersize', 8);
f3 = plot(w0, '--', 'linewidth', 2);
nummarkers([f1, f2, f3], 8);
xlabel(' '); ylabel('\bfw'); ylim([-0.1, 0.3]); title('\bfLinear Filter Weights');
text(2, 0.28, '({\bf\ita})', 'fontsize', 18);
h1 = legend(' SAF-MCC', ' SAF-ARC-MMSGD', ' desired \bfw');
set(h1, 'fontsize', 15, 'location', 'northeast', 'box', 'on');


figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 15);
f1 = plot(qxmcc, qymcc, '-o', 'linewidth', 2, 'markersize', 8);
f2 = plot(qxmsgd, qymsgd, '-s', 'linewidth', 2, 'markersize', 8);
f3 = plot(xx0, yy0, '--', 'linewidth', 2);
f4 = plot(xx0, xx0, 'k-.', 'linewidth', 1);
nummarkers([f1, f2, f3, f4], 8);
xlim([-1.6, 1.6]); ylim([-1.6, 1.6]); 
xlabel('Nonlinear input {\its}({\itn})'); ylabel('Nonlinear output {\ity}({\itn})'); title('\bfProfile of spline nonlinearity');
text(-1.4, 1.45, '({\bf\itb})', 'fontsize', 18);
h2 = legend(' SAF-MCC', ' SAF-ARC-MMSGD', ' desired', ' initialization');
set(h2, 'fontsize', 15, 'location', 'southeast', 'box', 'on');