function [M, w, qx, qy, C] = syspara(flag)
% Parameters setting
% [M, w, qx, qy, C] = syspara(flag)

C = 1/2*[-1,  3, -3,  1; ...
          2, -5,  4, -1; ...
         -1,  0,  1,  0; ...
          0,  2,  0,  0];
if flag == 0 % Desired system
    w = [0.6, -0.4, 0.25, -0.15, 0.1]';
    M = length(w); % linear filter length
    qx = linspace(-2.2, 2.2, 23)';
%     qy = [-1.5*ones(1, 3), -1.5:0.3:1.5, 1.5*ones(1, 3)]'; % saturation 0.03 0.05 1e4 qx = (linspace(-2, 2, 17))';
    qy = [-2.2:0.2:-0.8, -0.91, -0.42, -0.01, -0.1, 0.1, -0.15, 0.58, 1.2, 1:0.2:2.2]'; % 23
%     qy = [sign(qx(1:(end-1)/2)).*power(abs(qx(1:(end-1)/2)), 2/5); sign(qx((end-1)/2+1:end)).*power(abs(qx((end-1)/2+1:end)), 1/2)]; % harden
%     qy = [-2.2:0.2:-0.8, -0.91, -0.4, -0.2, 0.05, 0, -0.4, 0.58, 1, 1:0.2:2.2]';
else % Initialize filter weights
    M = 5;
    qlower = -2.2;
    qupper = 2.2;
    qnum = 23;
    
    w = zeros(M, 1); w(1) = 1; % initialize linear filter weights
    qx = linspace(qlower, qupper, qnum)';
    qy = qx; % initialize spline filter weights
end

% Preprocessing at start and end points
% qx = [qx_0, qx_1, ..., qx_n] (n+1)-by-1
% qy = [qy_0, qy_1, ..., qy_n] (n+1)-by-1
% qx_ext = [qx_-1, qx_0, qx_1, ..., qx_n, qx_n+1] (n+3)-by-1
% qy_ext = [qy_0, qy_0, qy_1, ..., qy_n, qy_n] (n+3)-by-1
qx = [qx(1)-(qx(2)-qx(1)); qx; qx(end)+(qx(end)-qx(end-1))];
qy = [qy(1); qy; qy(end)];

end