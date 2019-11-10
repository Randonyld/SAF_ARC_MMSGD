% SAF_ARC_MMSGD_WhiteNoise.m
% This is the code of the paper ''Spline adaptive filter with arctangent-momentum 
% strategy for nonlinear system identification''. 
% DOI:https://doi.org/10.1016/j.sigpro.2019.06.007
% Revised on 2019/11/10
clc; clear; close all;
%% Spline Adaptive Filtering
N = 1.2e4; % data length
x = zeros(N, 1); % input data
a = 0.9;
b = sqrt(1-a^2);
% randn('state', 3);

ntrial = 100; % number of trials
em = zeros(size(x)); % MSE
disp('>>> SAF algorithm start...');
for k = 1:ntrial
    fprintf('    Progcessing.  %d/%d\n', k, ntrial); % schedule
    % input signal
    x = filter(b, [1, -a], randn(size(x))); % x(n) = a*x(n-1) + sqrt(1-a^2)*kesi(n)
    %% Real System
    [M0, w0, qx0, qy0, C0] = syspara(0); % set parameters of the real system
    s0 = zeros(size(x)); % linear output
    y0 = zeros(size(x)); % spline output
    for n = M0:N
        s0(n) = w0'*x(n:-1:n-M0+1); % linear output
        [ind0, u0] = findiu(qx0, s0(n)); % find ind and u
        U0 = [u0^3, u0^2, u0, 1]'; % vector U
        Qi0 = qy0(ind0-1:ind0+2); % vector q
        y0(n) = U0'*C0*Qi0; % spline output
    end
    % add noise
    snr = 30; % signal-to-noise ratio
    noise = 10^(-snr/20)*randn(size(x)); % noise
    d = y0 + noise; % desired output
    if snr < 0 % no noise
        noise = zeros(size(x));
        d = y0;
    end
    % plot
    if ntrial == 1
        figure;
        subplot(311); plot(x); xlabel('n'); ylabel('x(n)'); title('System Input x(n)'); grid on; box on;
        subplot(312); plot(s0); xlabel('n'); ylabel('s(n)'); title('Linear Output s(n)'); grid on; box on;
        subplot(313); plot(d); xlabel('n'); ylabel('d(n)'); title('System Output d(n)'); grid on; box on;
    end
    %% Adaptive Filtering
    s = zeros(size(x)); % linear output
    y = zeros(size(x)); % output
    e = zeros(size(x)); % error
    [M, w, qx, qy, C] = syspara(1); % set parameters of filter
    dx = qx(2) - qx(1); % interval of qx
    
    rate_w = 0.01; % stepsize of linear filter
    rate_q = 0.01; % stepsize of spline filter
    gamma = 0.9; % momentum term
    lambda = 1.5;
    
    vw = zeros(M, 1);
    vq = zeros(4, length(qx));
    for n = M:N
        % filtering
        Xn = x(n:-1:n-M+1); % input buffer
        s(n) = w'*Xn; % linear output
        [ind, u] = findiu(qx, s(n)); % find ind and u
        U = [u^3, u^2, u, 1]'; % vector U
        Qi = qy(ind-1:ind+2); % vector q
        y(n) = U'*C*Qi; % spline output
        % update
        e(n) = d(n) - y(n); % error
        dU = [3*u^2, 2*u, 1, 0]'; % derivative of vector U
        
        gamma = gamma*0.9999;
        ed = lambda*norm(Xn)^2*e(n)/(norm(Xn)^4 + lambda^2*e(n)^4);
        Jdw = -1/dx*ed*dU'*C*Qi*Xn;
        if dot(vw, Jdw) < 0
            vw = rate_w*Jdw;
        else
            vw = gamma*vw + rate_w*Jdw;
        end
        w = w - vw; % update w
        
        Jdq = -ed*C'*U;
        if dot(vq(:, ind), Jdq) < 0
            vq(:, ind) = rate_q*Jdq; % update qy
        else
            vq(:, ind) = gamma*vq(:, ind) + rate_q*Jdq;
        end
        qy(ind-1:ind+2) = qy(ind-1:ind+2) - vq(:, ind); % update qy
    end
    em = em + e.^2;
end
%% Learning Curve
em = em/ntrial;
em(1:M) = 1e-1;
edb = 10*log10(em);
emf = zeros(size(edb));
lambda = 0.7;
for n = 2:length(emf)
    emf(n) = lambda*emf(n-1) + (1-lambda)*edb(n);
end
% [bb, aa] = butter(2, 0.02);
% emf = filter(bb, aa, edb);
noiseLevel(1: length(emf)) = -snr;

figure; hold on; grid on; box on;
set(gca, 'FontSize', 15, 'FontWeight', 'bold');
plot(emf, 'Color', [1 0 0], 'LineWidth', 2); plot(noiseLevel, '--', 'Color', [0 0 1], 'LineWidth', 2);
title('\bfSystem identification test'); xlabel('Samples'); ylabel('MSE/dB'); legend('MSE', 'NoiseLevel');
%% Plot
Co = linspecer(3);
figure; hold on; grid on; box on;
set(gca, 'FontSize', 15, 'FontWeight', 'bold');
plot(d, 'color', Co(1, :)); plot(y, 'color', Co(3, :)); plot(e, 'color', Co(2, :)); plot(noise);
xlabel('Samples'); title('\bfSystem identification test');
legend('desired d', 'filtered y', 'error e', 'noise n', 'location', 'best');

figure; hold on; grid on; box on;
set(gca, 'FontSize', 15, 'FontWeight', 'bold');
plot(w0, 'b', 'linewidth', 3); plot(w, 'r--', 'linewidth', 3); 
ylabel('\bfw'); title('\bfLinear Filter Weights');
l1 = legend(' desired', ' filtered', 'location', 'best');
set(l1, 'fontsize', 15, 'location', 'northeast', 'box', 'on');

[xx0, yy0] = interp(qx0, qy0, 200);
[xx, yy] = interp(qx, qy, 200);
figure; hold on; grid on; box on; xlim([qx(2), qx(end-1)]); ylim([qy(2), qy(end-1)]);
set(gca, 'FontSize', 15, 'FontWeight', 'bold');
plot(xx0, yy0, 'b', 'linewidth', 3); plot(xx, yy, 'r--', 'linewidth', 3); plot(qx, qx, 'k--', 'linewidth', 1);
xlabel('Nonlinear input {\its}({\itn})'); ylabel('Nonlinear output {\ity}({\itn})'); title('\bfProfile of spline nonlinearity');
l2 = legend(' desired', ' filtered', ' initialization', 'location', 'southeast');
set(l2, 'fontsize', 15, 'location', 'southeast', 'box', 'on');
%% Error Estimate
cem = em(9/10*end:end);
msgd_mean = mean(cem);
msgd_std = std(cem);
fprintf('    MSE = %5.4e +/- %5.4e\n', mean(cem), std(cem));
disp('>>> SAF-ARC-MMSGD algorithm end.');
%% Save
msgd2 = emf;
save a2.mat msgd2 a