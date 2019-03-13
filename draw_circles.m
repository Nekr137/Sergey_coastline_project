function draw_circles(x0,y0,r0,r_finish,step)
% анонимная функция, рисующая круг
plotCircle = @(xc, yc, R) plot(xc + R * cos(0:0.001:2*pi), ...
                                yc + R * sin(0:0.001:2*pi),...
                                'Color',[0.7 0.7 0.7],...
                                'LineWidth',0.1);

% рисуем много кругов в цикле
for st = r0:step:r_finish
    plotCircle(x0,y0,st)
end
end