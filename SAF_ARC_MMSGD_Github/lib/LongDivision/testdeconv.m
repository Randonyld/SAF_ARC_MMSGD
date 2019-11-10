% 多项式除法，商式和余式
clc; clear all; close all;

%%
num = [1 0.2 0 0 0 0];
den = [1 -1.7 0.7];
[q, r] = deconv(num, den)
% q是商式，r是余式
% 结果中从零次到N次，依次从右到左排列

conv([1 0.5 0 0], [1 1.9 2.53 2.971])

% %% j = 1
% num = [1 0 0 0];
% den = [1 -3 3.1 -1.1];
% [q, r] = deconv(num, den)
% conv([1 2], [1 0])

% %% j = 2
% num = [1 0 0 0 0];
% den = [1 -3 3.1 -1.1];
% [q, r] = deconv(num, den)
% conv([1 2], [1 3])