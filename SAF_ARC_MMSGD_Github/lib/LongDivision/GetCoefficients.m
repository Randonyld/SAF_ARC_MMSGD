%%%%%%%%%%%%%%%%%%%%% 
% GetCoefficients.m % 
%%%%%%%%%%%%%%%%%%%%%
function c = GetCoefficients(den, index) 

n = length(den); 
if n-index >n | n-index <1 
    c = 0; 
else 
    c = den(n-index); 
end
end