function Value = SetRadiiTextLabels(x,y,values,x0,y0,step,r0,r_finish)
r = sqrt((x-x0).^2 + (y-y0).^2); % радиусы
strip = 1;
for R = r0+step:step:r_finish    % для каждой дуги
    num = find(r>R-step & r<R);  % эта строчка выдает номера элементов 
                                 % векторов, значения которых лежат в
                                 % диапазоне радиусов
    plot(x(num),y(num),'rx','MarkerSize',1.5);    % выводим
    Value(strip) = sum(values(num));    strip = strip + 1; % суммируем величины 
                                % и увеличиваем индекс на единицу, переходим к следующей полоске
    text(x0,y0+R-step,num2str(Value(strip-1),3),'FontSize',9);
    pause(0.1); % пауза для визуализации
end
end

