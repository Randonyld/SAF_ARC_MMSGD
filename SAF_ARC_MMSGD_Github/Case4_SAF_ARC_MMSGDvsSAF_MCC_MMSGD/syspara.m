function [M, w, qx, qy, C] = syspara(flag)
% Parameters setting
% [M, w, qx, qy, C] = syspara(flag)

C = 1/2*[-1,  3, -3,  1; ...
          2, -5,  4, -1; ...
         -1,  0,  1,  0; ...
          0,  2,  0,  0];
if flag == 0 % Desired system
    [w, n] = LongDiv([0.0154, 0.0462, 0.0462, 0.0154], [1, -1.99, 1.572, -0.4583], 40);
    w = w';
    M = length(w); % linear filter length
    qx = linspace(-1.6, 1.6, 23)';
    qy = sin(qx);
else % Initialize filter weights
    M = 40;
    qlower = -1.6;
    qupper = 1.6;
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