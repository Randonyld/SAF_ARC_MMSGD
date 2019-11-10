% SAF_VSS_SNLMS.m
% include lib: syspara.m  findiu.m  interp.m  linspecer.m  textprogressbar.m
% Copyright  yld  XJTU  Aug. 28, 2018
clc; clear; close all;
%% Spline Adaptive Filtering
N = 8e4; % data length
x = zeros(N, 1); % input data
a = 0.1;
b = sqrt(1-a^2);

ntrial = 10; % number of trials
em = zeros(size(x)); % MSE
disp('>>> SAF algorithm start...');

time0 = 0;
for k = 1:ntrial
    fprintf('    Progcessing.  %d/%d\n', k, ntrial); % schedule
    % input signal
    x = filter(b, [1, -a], randn(size(x))); % x(n) = a*x(n-1) + sqrt(1-a^2)*kesi(n)
    %% Real System
    [M0, w0, qx0, qy0, C0] = syspara(0); % set parameters of the real system
    s0 = zeros(size(x)); % linear output
    y0 = zeros(size(x)); % spline output
    for n = 4:N
        s0(n) = 1.99*s0(n-1) - 1.572*s0(n-2) + 0.4583*s0(n-3) + 0.0154*x(n) + ...
            0.0462*x(n-1) + 0.0462*x(n-2) + 0.0154*x(n-3);
        y0(n) = sin(s0(n));
    end
    % add noise
    snr = 30; % signal-to-noise ratio
    noise = 10^(-snr/20)*randn(size(x)); % noise
    noisei = stblrnd(1.6, 0, 0.05, 0, N, 1);
    d = y0 + noise + noisei; % desired output
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
    e2 = zeros(size(x)); % e^2
    e02 = zeros(size(x));
    [M, w, qx, qy, C] = syspara(1); % set parameters of filter
    dx = qx(2) - qx(1); % interval of qx
    
    Nw = 15;
    rate_w = zeros(size(x)); % stepsize of linear filter
    rate_q = zeros(size(x)); % stepsize of spline filter
    rate_w(1:Nw) = 0.001;
    rate_q(1:Nw) = 0.003;
    tic
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
        
        qy(ind-1:ind+2) = qy(ind-1:ind+2) + rate_q(n-1)*sign(e(n))/sqrt(U'*U + 1e-3)*C'*U;
        w = w + rate_w(n-1)*sign(e(n))/sqrt(U'*U + 1e-3)/dx*dU'*C*qy(ind-1:ind+2)*Xn;
        
        e2(n) = e(n)^2;
        epsilon = median(e2(n:-1:n-Nw+1));
        e02(n) = 0.99*e02(n-1) + 1.483*(1+5/(Nw-1))*0.01*epsilon;
        rate_w(n) = 0.99*rate_w(n-1) + 0.01*min(e02(n), rate_w(n-1));
        rate_q(n) = 0.99*rate_q(n-1) + 0.01*min(e02(n), rate_q(n-1));
    end
    t = toc;
    time0 = time0 + t;
    em = em + (e - noisei).^2;
end
time0 = time0/ntrial
%% Learning Curve
em = em/ntrial;
em(1:max(Nw, M)) = 1e-1;
edb = 10*log10(em);
emf = zeros(size(edb));
lambda = 0.998;
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
plot(w0, 'b', 'linewidth', 2); plot(w, 'r--', 'linewidth', 2); 
ylabel('\bfw'); title('\bfLinear Filter Weights');
l1 = legend(' desired', ' filtered', 'location', 'best');
set(l1, 'fontsize', 15, 'location', 'northeast', 'box', 'on');

[xx0, yy0] = interp(qx0, qy0, 200);
[xx, yy] = interp(qx, qy, 200);
figure; hold on; grid on; box on; xlim([qx(2), qx(end-1)]); ylim([qy(2), qy(end-1)]);
set(gca, 'FontSize', 15, 'FontWeight', 'bold');
plot(xx0, yy0, 'b', 'linewidth', 2); plot(xx, yy, 'r--', 'linewidth', 2); plot(qx, qx, 'k--', 'linewidth', 1);
xlabel('Nonlinear input {\its}({\itn})'); ylabel('Nonlinear output {\ity}({\itn})'); title('\bfProfile of spline nonlinearity');
l2 = legend(' desired', ' filtered', ' initialization', 'location', 'southeast');
set(l2, 'fontsize', 15, 'location', 'southeast', 'box', 'on');
%% Error Estimate
cem = em(9/10*end:end);
vss_mean = mean(cem);
vss_std = std(cem);
fprintf('    MSE = %5.4e +/- %5.4e\n', mean(cem), std(cem));
disp('>>> SAF-VSS-SNLMS algorithm end.');
%% Save
emf_safvsssnlms = emf;
save safvsssnlms.mat emf_safvsssnlms vss_mean vss_std

if ntrial == 1
    wsnlms = w;
    qxsnlms = xx;
    qysnlms = yy;
    save snlms.mat wsnlms qxsnlms qysnlms
end