%%%%%%%%%%%%%%
% LongDiv0.m % 
%%%%%%%%%%%%%%
function [c,n] = LongDiv0(den, len)
% polynomial 'long' division Base-Type.
%   [c,n] = LongDiv0(den, len)
% include: GetCoefficients()
%   means 1/den, where, 'den' is denominator and 'len' is the 
%   expected number of the items in quotient. 'c' is the quotient
%   whose elements nubmer are limited to len and 'n' is the power 
%   of the polynomial. Generally, it can be described as following:
%                   1
%   ---------------------------------=c(1)z^(-n)+c(2)z^(-n-1)+...+c(k)z^(-n-k+1)+...
%   z^n+a(n-1)z^(n-1)+...+ a(1)z+a(0)
%   where,
%         den = [a(n-1),a(n-2),...,a(1),a(0)].
%   and the output:
%         c  = [c(1),c(2),....c(k)z^(-n-k+1),...c(len)z^(-n-len+1)];
%   for example:
%        1            
%  (1) -----  ; where, den=[a(0)]=[1]; so [c,n] = hyLongDIV0(1,10)
%       z+1  
%   we can see:    c = [1 -1 1 -1 1 -1 1 -1 1 -1]; n = 1;
%   so the result is: z^(-1)-z^(-2)+z^(-3)-...+z^(-9)-z^(-10)            
%           1           1
%  (2) ---------- = ---------; where, den=[a(1) a(0)]=[4 4]; so hyLongDIV0([4 4],10)
%      (z+2)(z+2)   z^2+4z+4  
%   we can see:    c = [1 -4 12 -32 80 -192 448 -1024 2304 -5120]; n = 2
%   the result is omited because it's so sample and you can give it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = []; n = 0;
[mDen, nDen] = size(den);
if min(mDen, nDen) ~= 1
   disp('  ERROR: The first paramater must be vector');
   return
end
if len < 1
   disp('  ERROR: The scecond paramater should not be smaller than 1');
   return
elseif len < 4
   nLoop = 4;
else
   nLoop = len;
end
%多项式阶数
n =length(den);
%长除所得商的系数
c1 = 1;
c2 = -GetCoefficients(den, n-1);
c3 = -GetCoefficients(den, n-2) + c2*c2;
c = [c1 c2 c3];
for k = 4:nLoop
   sum = 0;
   for i = 1:k-3
      sum = sum + GetCoefficients(den,n-i)*c(k-i);
   end
   ck = -GetCoefficients(den,n-k+1) + GetCoefficients(den,n-1)*GetCoefficients(den,n-k+2) - sum;
   c = [c ck];
end
c = c(1:len);
end