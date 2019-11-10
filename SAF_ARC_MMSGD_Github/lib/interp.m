function [x, y] = interp(qx, qy, n)
% Spline Interpolation
% [x, y] = interp(qx, qy, n)

x = (linspace(qx(2), qx(end-1), n))';
y = zeros(size(x));
for i = 1:length(x)
    [ind, u] = findiu(qx, x(i)); % find ind and u
    U = [u^3, u^2, u, 1]'; % vector U
    Qi = qy(ind-1:ind+2); % vector q
    C = [-1,  3, -3,  1; ...
        2, -5,  4, -1; ...
        -1,  0,  1,  0; ...
        0,  2,  0,  0]*1/2;
    y(i) = U'*C*Qi; % spline output
end

end