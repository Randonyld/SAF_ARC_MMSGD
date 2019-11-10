function nummarkers(h, hnum)
% NUMMARKERS takes a vector of line handles in h and reduces the number of plot 
% markers on the lines to num. This is useful for closely sampled data.
%
% Example:
% t = 0:0.01:pi;
% figure; hold on;
% p1 = plot(t, sin(t), '-*', 'linewidth', 2, 'markersize', 10);
% p2 = plot(t, cos(t), '-o', 'linewidth', 2, 'markersize', 10);
% p = [p1, p2];
% nummarkers(p, 10);
% legend('sin(t)', 'cos(t)');
%
% 
% Created: Magnus Sundberg Feb 08, 2001
% Modified: [email]felonwan@gmail.com[/email] May 25, 2013
% Revised: [email]liangdong.yang6@gmail.com[/email] Aug 20, 2018

lenh = length(h);
lenhn = length(hnum);
if (lenhn ~= lenh && lenhn ~= 1)
    error('The number of markers should be a scalar or a vector with equal length to the number of lines!');
end
for n = 1:lenh
    if lenhn == 1
        num = hnum;
    elseif lenhn == lenh
        num = hnum(n);
    end
    if strcmp(get(h(n), 'type'), 'line')
        axes(get(h(n), 'parent'));
        x = get(h(n), 'xdata');
        y = get(h(n), 'ydata');
        lx = length(x);
    elseif(lx < 2*num)
        disp('Warning: Data points are not so many. Not necessary to use this function!');
    end
    xd = diff(get(gca, 'xlim'));
    yd = diff(get(gca, 'ylim'));
    s = [0 cumsum(sqrt(diff(x/xd).^2+diff(y/yd).^2))];
    si = (0:num-1)*s(end)/(num-1);
    ti = zeros(num, 1);
    ti(1) = 1;
    ti(num) = lx;
    for i = 2:num-1
        [~, ti(i)] = min(abs(s-si(i)));
    end
    xi = x(ti);
    yi = y(ti);
    marker = get(h(n), 'marker');
    markersize = get(h(n), 'markersize');
    color = get(h(n), 'color');
    style = get(h(n), 'linestyle');
    linewidth = get(h(n), 'linewidth');
    % make a line with just the markers
    set(line(xi, yi), 'linewidth', linewidth, 'linestyle','none', 'marker', marker, 'markersize', markersize, 'color', color);
    % make a copy of the old line with no markers
    set(line(x, y), 'linewidth', linewidth, 'linestyle', style, 'marker', 'none', 'color', color);
    % set the xdata and ydata of the old line to [], this tricks legend to keep on working
    set(h(n), 'xdata', [], 'ydata', []);
end

end