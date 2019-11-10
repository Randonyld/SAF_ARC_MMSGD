function [ind, u] = findiu(qx, sn)
% find index i and normalized coordinate u of sn
% [ind, u] = findiu(qx, sn)
% Nq = n + 1
% qx = [qx_0, qx_1, ..., qx_n] (n+1)-by-1
% qx = [qx(1), qx(2), ..., qx(Nq)] (n+1)-by-1
% qx_ext = [qx_-1, qx_0, qx_1, ..., qx_n, qx_n+1] (n+3)-by-1
% qx_ext = [qx(0), qx(1), qx(2), ..., qx(Nq), qx(Nq+1)] (n+3)-by-1
% qx_ext = [qx(1), [qx(2), qx(3), ..., qx(Nq), qx(Nq+1)], qx(Nq+2)] (n+3)-by-1

% ind from 2 to lenth(qx)-2
if sn < qx(2)
    ind = 2;
    u = 0;
    return;
elseif sn >= qx(end-1)
    ind = length(qx) - 2;
    u = 1;
    return;
end
for i = 2:length(qx)-1
    if sn >= qx(i) && sn < qx(i+1)
        ind = i;
    end
end
u = (sn - qx(ind))/(qx(ind+1)-qx(ind));


% qx_step = 0.2;
% qlen = length(qx);
% Su = sn/qx_step + (qlen-1)/2;
% ind =  floor(Su);
% u = Su - ind;
% if ind < 1 % the index must start from 1
%     ind = 1;
% elseif ind > (qlen - 3)
%     ind = qlen - 3;
% end
% ind = ind+1;

end