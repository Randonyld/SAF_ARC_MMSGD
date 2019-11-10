%%%%%%%%%%%%%
% LongDiv.m % 
%%%%%%%%%%%%%
function [c, n] = LongDiv(num, den, len)
% polynomial 'long' division.
%   [c,n] = LongDiv(num, den, len)
% include: LongDiv0(), GetCoefficients()
%   means num/den, where, 'num' is nominator and 'den' is denominator, both 
%   'num' and 'den' are vector. 'len' is the expected number of the items in
%   quotient. As output, 'c' is the quotient whose elements number are limited
%   to len and 'n' is the power of the quotient's first item. Generally, it 
%   can be described as following:
%               b(m)*z^m+b(m-1)*z^(m-1)+...+b(1)*z+b(0)
%       f(z) =  ---------------------------------------
%               a(n)*z^n+a(n-1)*z^(n-1)+...+a(1)*z+a(0)
%   where,
%       num = [b(m), b(m-1), ..., b(1), b(0)]
%       den = [a(n), a(n-1), ..., a(1), a(0)]
%   and the output:
%       c  = [c(1), c(2), ..., c(len)];
%       n ;
%   so the result is:
%       f(z) = c(1)*z^n + c(2)*z^(n-1)+...+c(len)*z^(n-len+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = []; n = 0;
[mNum, nNum] = size(num);
[mDen, nDen] = size(den);
if min(mDen, nDen) ~= 1 | min(mNum, nNum) ~= 1
   disp('  ERROR: The first or second paramater must be vector');
   return
end
if isempty(num)
   disp('  ERROR: nominator should not be empty');
   return
end
%输入参数预处理
m = length(num) - 1;
if length(den) > 1
   num = num/den(1);
 den = den/den(1);
   den = den(2:length(den));
elseif length(den) == 1
   n = m;
   c = num/den(1);
   return
else
   disp('  ERROR: denominator should not be empty');
   return
end
if mNum ~= 1
   num = num';
end
if mDen ~= 1
   den = den';
end
c = zeros(1, len);
%计算长除基本型
[c0,n0] = LongDiv0(den, len+m);
%将原式拆分成基本型,然后累加
for i = 0:m
   ci = [];
   ci = [zeros(1,m-i) num(m-i+1)*c0];
   ci = ci(1:len);
   c = c + ci;
end
n = m - n0;
end