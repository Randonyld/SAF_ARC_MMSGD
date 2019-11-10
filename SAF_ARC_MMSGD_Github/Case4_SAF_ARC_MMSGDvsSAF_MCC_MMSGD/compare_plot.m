clc; clear; close all;
load safmcc01.mat
load safmcc02.mat
load safmcc05.mat
load safmcc10.mat
load safmcc20.mat
load safmcc010.mat
load safarcmmsgd20.mat
load safarcmmsgd50.mat
load safarcmmsgd100.mat
load safarcmmsgd200.mat

mmsgd20 = emf_safarcmmsgd20;
mmsgd50 = emf_safarcmmsgd50;
mmsgd100 = emf_safarcmmsgd100;
mmsgd200 = emf_safarcmmsgd200;
mcc010 = emf_safmcc010;
mcc01 = emf_safmcc01;
mcc02 = emf_safmcc02;
mcc05 = emf_safmcc05;
mcc10 = emf_safmcc10;
mcc20 = emf_safmcc20;

lambda = 0.998;
for n = 2:length(emf_safmcc01)
    emf_safarcmmsgd20(n) = lambda*emf_safarcmmsgd20(n-1) + (1-lambda)*mmsgd20(n);
    emf_safarcmmsgd50(n) = lambda*emf_safarcmmsgd50(n-1) + (1-lambda)*mmsgd50(n);
    emf_safarcmmsgd100(n) = lambda*emf_safarcmmsgd100(n-1) + (1-lambda)*mmsgd100(n);
    emf_safarcmmsgd200(n) = lambda*emf_safarcmmsgd200(n-1) + (1-lambda)*mmsgd200(n);
    emf_safmcc010(n) = lambda*emf_safmcc010(n-1) + (1-lambda)*mcc010(n);
    emf_safmcc01(n) = lambda*emf_safmcc01(n-1) + (1-lambda)*mcc01(n);
    emf_safmcc02(n) = lambda*emf_safmcc02(n-1) + (1-lambda)*mcc02(n);
    emf_safmcc05(n) = lambda*emf_safmcc05(n-1) + (1-lambda)*mcc05(n);
    emf_safmcc10(n) = lambda*emf_safmcc10(n-1) + (1-lambda)*mcc10(n);
    emf_safmcc20(n) = lambda*emf_safmcc20(n-1) + (1-lambda)*mcc20(n);
end

figure; grid on; hold on; box on;
set(gca, 'fontweight', 'bold', 'FontSize', 20);
f0 = plot(emf_safmcc010, '-*', 'linewidth', 3, 'markersize', 12);
f1 = plot(emf_safmcc01, '-s', 'linewidth', 3, 'markersize', 12);
f2 = plot(emf_safmcc02, '-v', 'linewidth', 3, 'markersize', 12);
f3 = plot(emf_safmcc05, '-^', 'linewidth', 3, 'markersize', 12);
f4 = plot(emf_safmcc10, '-d', 'linewidth', 3, 'markersize', 12);
f5 = plot(emf_safmcc20, '-+', 'linewidth', 3, 'markersize', 12);
f6 = plot(emf_safarcmmsgd20, '--o', 'linewidth', 3, 'markersize', 12);
f7 = plot(emf_safarcmmsgd50, '--x', 'linewidth', 3, 'markersize', 12);
f8 = plot(emf_safarcmmsgd100, '--+', 'linewidth', 3, 'markersize', 12);
f9 = plot(emf_safarcmmsgd200, '--d', 'linewidth', 3, 'markersize', 12);
nummarkers([f0, f1, f2, f3, f4, f5, f6, f7, f8, f9], 8);

% plot(-30*ones(size(emf_saflms)), '--', 'linewidth', 2);
xlabel('Samples'); ylabel('MSE [dB]'); %ylim([-30, 30]);

set(gca, 'XTick', [0, 20000, 40000, 60000, 80000]);
set(gca, 'XTicklabel', [0, 20000, 40000, 60000, 80000]);

h1 = legend(' SAF-MCC \sigma = 0.2', ' SAF-MCC-MMSGD \sigma = 0.1', ' SAF-MCC-MMSGD \sigma = 0.2', ' SAF-MCC-MMSGD \sigma = 0.5', ' SAF-MCC-MMSGD \sigma = 1.0', ' SAF-MCC-MMSGD \sigma = 2.0',...
    ' SAF-ARC-MMSGD \lambda = 2.0', ' SAF-ARC-MMSGD \lambda = 5.0', ' SAF-ARC-MMSGD \lambda = 10.0', ' SAF-ARC-MMSGD \lambda = 20.0');
set(h1, 'fontsize', 16, 'location', 'northeast', 'box', 'on');

axes('position', [0.28, 0.6, 0.3, 0.2]);
hold on; grid on; box on;
f0 = plot(emf_safmcc010(1:500), '-*', 'linewidth', 3, 'markersize', 12);
f1 = plot(emf_safmcc01(1:500), '-s', 'linewidth', 3, 'markersize', 12);
f2 = plot(emf_safmcc02(1:500), '-v', 'linewidth', 3, 'markersize', 12);
f3 = plot(emf_safmcc05(1:500), '-^', 'linewidth', 3, 'markersize', 12);
f4 = plot(emf_safmcc10(1:500), '-d', 'linewidth', 3, 'markersize', 12);
f5 = plot(emf_safmcc20(1:500), '-+', 'linewidth', 3, 'markersize', 12);
f6 = plot(emf_safarcmmsgd20(1:500), '--o', 'linewidth', 3, 'markersize', 12);
f7 = plot(emf_safarcmmsgd50(1:500), '--x', 'linewidth', 3, 'markersize', 12);
f8 = plot(emf_safarcmmsgd100(1:500), '--+', 'linewidth', 3, 'markersize', 12);
f9 = plot(emf_safarcmmsgd200(1:500), '--d', 'linewidth', 3, 'markersize', 12);
nummarkers([f0, f1, f2, f3, f4, f5, f6, f7, f8, f9], 5);
set(gca, 'fontweight', 'bold', 'FontSize', 18);

axes('position', [0.55, 0.3, 0.3, 0.2]);
hold on; grid on; box on;
kedu = length(emf_safmcc02) - 500:length(emf_safmcc02);
f0 = plot(kedu, emf_safmcc010(kedu), '-*', 'linewidth', 3, 'markersize', 12);
f1 = plot(kedu, emf_safmcc01(kedu), '-s', 'linewidth', 3, 'markersize', 12);
f2 = plot(kedu, emf_safmcc02(kedu), '-v', 'linewidth', 3, 'markersize', 12);
f3 = plot(kedu, emf_safmcc05(kedu), '-^', 'linewidth', 3, 'markersize', 12);
f4 = plot(kedu, emf_safmcc10(kedu), '-d', 'linewidth', 3, 'markersize', 12);
f5 = plot(kedu, emf_safmcc20(kedu), '-', 'linewidth', 3, 'markersize', 12);
f6 = plot(kedu, emf_safarcmmsgd20(kedu), '--o', 'linewidth', 3, 'markersize', 12);
f7 = plot(kedu, emf_safarcmmsgd50(kedu), '--x', 'linewidth', 3, 'markersize', 12);
f8 = plot(kedu, emf_safarcmmsgd100(kedu), '--+', 'linewidth', 3, 'markersize', 12);
f9 = plot(kedu, emf_safarcmmsgd200(kedu), '--d', 'linewidth', 3, 'markersize', 12);
nummarkers([f0, f1, f2, f3, f4, f5, f6, f7, f8, f9], 5);
set(gca, 'fontweight', 'bold', 'FontSize', 16);
ylim([-29.3, -26.7]);
set(gca, 'XTick', [79500, 79600, 79700, 79800, 79900, 80000]);
set(gca, 'XTicklabel', [79500, 79600, 79700, 79800, 79900, 80000]);