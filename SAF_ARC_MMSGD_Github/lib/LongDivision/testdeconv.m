% ����ʽ��������ʽ����ʽ
clc; clear all; close all;

%%
num = [1 0.2 0 0 0 0];
den = [1 -1.7 0.7];
[q, r] = deconv(num, den)
% q����ʽ��r����ʽ
% ����д���ε�N�Σ����δ��ҵ�������

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