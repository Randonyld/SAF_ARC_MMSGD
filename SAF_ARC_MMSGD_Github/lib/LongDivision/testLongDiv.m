% 长除法，保留有限项的商式，忽略余式
clc; clear all; close all;

num = [1.2 0.4];
den = [1 1.2 0.55];
len = 18;
[h, n] = LongDiv(num, den, len)
figure; plot(h, 'r*'); axis([0 len+1 -1.1 1.25]); hold on; plot(h); hold on;

b8 = 8/100*abs(h(1));
b1 = 1/100*abs(h(1));

plot(b8*ones(size(h)), 'r--'); hold on; plot(-b8*ones(size(h)), 'r--'); hold on;
plot(b1*ones(size(h)), 'k--'); hold on; plot(-b1*ones(size(h)), 'k--'); hold on;
xlabel('k'); ylabel('h');

h8 = h(1:8);
h1 = h(1:16);

save h.mat h8 h1